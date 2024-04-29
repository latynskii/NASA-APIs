import UIKit

class APODsAssembly {

    static func assemble() -> (view: UIViewController, module: APODsModuleOutput & APODsModuleInput) {
        let view = APODsViewController()
        let presenter = APODsPresenter()
        let interactor = APODsInteractor()
        let collectionManager = APODsCollectionViewManager()
        view.presenter = presenter
        view.collectionManagerInput = collectionManager
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        collectionManager.delegate = presenter
        interactor.service = PODsService(networkManager: NetworkManager())
        return (view, presenter)
    }

}
