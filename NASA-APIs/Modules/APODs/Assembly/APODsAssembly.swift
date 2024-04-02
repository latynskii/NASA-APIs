import UIKit

class APODsAssembly {

    static func assemble() -> (view: UIViewController, output: APODsModuleOutput) {
        let view = APODsViewController()
        let presenter = APODsPresenter()
        let interactor = APODsInteractor()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter

        return (view, presenter)
    }

}
