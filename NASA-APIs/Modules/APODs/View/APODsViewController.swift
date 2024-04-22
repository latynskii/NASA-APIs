import UIKit

private struct Appearance {
    static let backgroundColor: UIColor = .lightGray
}

final class APODsViewController: UIViewController {

    var presenter: APODsViewOutput!
    var collectionManagerInput: APODsCollectionViewManagerInput!

    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewLayout()
        )
        collection.backgroundColor = Appearance.backgroundColor
        return collection
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        makeConstraints()
        collectionManagerInput.connect(with: collectionView)
        presenter.viewDidLoad()
        view.backgroundColor = Appearance.backgroundColor
        title = "NASA APODs"
    }

    private func addSubviews() {
        view.addSubview(collectionView)
    }

    private func makeConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    deinit {
        presenter.viewDidDeInited()
    }
}

extension APODsViewController: APODsViewInput {
    func customDatesCellTapped(fromValue: String, toValue: String, selected: Bool) {
        collectionManagerInput.customDateCellPicked(from: fromValue, to: toValue, selected: selected)
    }
    
    func setDateSelect(section: APODsSection) {
        collectionManagerInput.appendDateSelection(section)
    }

    func setPictures(section: APODsSection) {
        collectionManagerInput.appendPicturesSection(section)
    }

    func dateCellTapped(indexPath: IndexPath, selected: Bool) {
        collectionManagerInput.dateCellPicked(with: indexPath, selected: selected)
    }
}
