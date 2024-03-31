import UIKit

class APIListAssembly {

    static func assemble() -> (view: UIViewController, output: APIListModuleOutput) {
        let view = APIListViewController()
        let presenter = APIListPresenter()
        let interactor = APIListInteractor()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter

        return (view, presenter)
    }

}
