import UIKit

private struct Appearance {
    static let backgroundColor: UIColor = .grayBackground
}

final class APODsViewController: BaseViewController {

    var presenter: APODsViewOutput!
    var collectionManagerInput: APODsCollectionViewManagerInput!

    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewLayout()
        )
        collection.backgroundColor = Appearance.backgroundColor
        collection.contentInset.bottom = 40
        return collection
    }()

    private lazy var bottomBar: BottomBarView = {
        let view = BottomBarView(title: "NASA API", onLeftTapped: {}, onRightTapped: {})
        view.delegate = presenter
        return view
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
        view.addSubview(bottomBar)
    }

    private func makeConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        bottomBar.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
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

    func setLoader(state: Bool) {
        ( state ? self.showLoader() : hideLoader() )
    }
}
