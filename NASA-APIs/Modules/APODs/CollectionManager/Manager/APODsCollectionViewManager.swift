
import UIKit

protocol APODsCollectionViewManagerInput: AnyObject {
    func connect(with collectionView: UICollectionView)
    func appendDateSelection(_ section: APODsSection)
    func customDateCellPicked(from: String, to: String, selected: Bool)
}

private extension APODsCollectionViewManager {
    func section(by index: Int) -> APODsSection? {
        let snapshot = dataSource.snapshot()
        let sections = snapshot.sectionIdentifiers
        guard index < sections.count else { return nil }
        return sections[index]
    }
}

protocol APODsCollectionViewManagerDelegate: AnyObject {
    func cellTapped(section: APODsSection, item: APODsCellItem)
}

final class APODsCollectionViewManager: NSObject {

    weak var delegate: APODsCollectionViewManagerDelegate?

    private var collectionView: UICollectionView!

    private lazy var dataSource: UICollectionViewDiffableDataSource<APODsSection, APODsCellItem> = {
        let dataSource = UICollectionViewDiffableDataSource<APODsSection, APODsCellItem>(
            collectionView: collectionView,
            cellProvider: makeDataSource())
        dataSource.supplementaryViewProvider = makeHeader()
        return dataSource
    }()

    private func makeHeader() -> UICollectionViewDiffableDataSource<APODsSection, APODsCellItem>.SupplementaryViewProvider {
        return { [weak self] collectionView, kind, indexPath in
            guard let self = self,
                    let section = section(by: indexPath.section) else {
                return nil
            }
            switch section.type {
            case .dataSelectType:
                guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: APODsCollectionHeaderView.identifier,
                    for: indexPath) as? APODsCollectionHeaderView else { fatalError() }
                sectionHeader.setup(title: section.title)
                return sectionHeader
            }
        }
    }

    func makeDataSource() -> UICollectionViewDiffableDataSource<APODsSection, APODsCellItem>.CellProvider {
        { (collectionView: UICollectionView, indexPath: IndexPath, identifier: APODsCellItem) -> UICollectionViewCell? in
            switch identifier.type {
            case .dataSelectItemType(let type):
                if type.type == .custom {
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: APODCustomDateCell.identifier,
                        for: indexPath) as? APODCustomDateCell
                    return cell
                }
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: APODsSelectDateCell.identifier, for: indexPath) as? APODsSelectDateCell
                cell?.setup(title: type.type.description)
                return cell
            }
        }
    }
}

// MARK: - APODsCollectionViewManagerInput
extension APODsCollectionViewManager: APODsCollectionViewManagerInput {

    func connect(with collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.collectionView.collectionViewLayout = makeCompositionalLayout()
        self.collectionView.delegate = self
        self.collectionView.register(
            APODsSelectDateCell.self,
            forCellWithReuseIdentifier: APODsSelectDateCell.identifier
        )
        self.collectionView.register(
            APODCustomDateCell.self,
            forCellWithReuseIdentifier: APODCustomDateCell.identifier
        )
        self.collectionView.register(
            APODsCollectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: APODsCollectionHeaderView.identifier
        )
    }

    func appendDateSelection(_ section: APODsSection) {
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([section])
        snapshot.appendItems(section.items, toSection: section)
        dataSource.apply(snapshot)
    }

    func customDateCellPicked(from: String, to: String, selected: Bool) {
        guard let cell = collectionView.visibleCells.first(where: { $0 is APODCustomDateCell }) as? APODCustomDateCell else { return }
        (selected ? cell.selectDates(from: from, until: to) : cell.unselectDates())
    }
}

extension APODsCollectionViewManager: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = section(by: indexPath.section) else { return }
        let item = section.items[indexPath.row]
        delegate?.cellTapped(section: section, item: item)
    }
}


// MARK: - Layout
private extension APODsCollectionViewManager {

    func makeCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [unowned self] sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
            return makeSection(by: sectionIndex)
        }
        return layout
    }

    func makeSection(by index: Int) -> NSCollectionLayoutSection? {
        guard let type = APODsSectionType(rawValue: index) else { return nil }
        switch type {
        case .dataSelectType:
            return makeDataSelectSection()
        }
    }

    func makeDataSelectSection() -> NSCollectionLayoutSection? {

        let containerGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(128))

        let leadingGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.325),
            heightDimension: .absolute(124)
        )

        let trailingGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.35),
            heightDimension: .absolute(124)
        )


        let leadingItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )

        let trailingItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))

        let leadingItem = NSCollectionLayoutItem(layoutSize: leadingItemSize)
        leadingItem.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
        let trailingItem = NSCollectionLayoutItem(layoutSize: trailingItemSize)
        trailingItem.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)

        let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: trailingGroupSize, subitem: trailingItem, count: 1)
        let ladingGroup1 = NSCollectionLayoutGroup.vertical(layoutSize: leadingGroupSize, subitem: leadingItem, count: 2)
        let containerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: containerGroupSize, subitems: [ladingGroup1, ladingGroup1, trailingGroup])
        let section = NSCollectionLayoutSection(group: containerGroup)
        section.interGroupSpacing = 4
//        section.boundarySupplementaryItems = [makeHeader()]
        section.contentInsets = .init(top: 8, leading: 16, bottom: 0, trailing: 16)
        return section
    }

    func makeHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(1))

        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading)
        return sectionHeader
    }
}
