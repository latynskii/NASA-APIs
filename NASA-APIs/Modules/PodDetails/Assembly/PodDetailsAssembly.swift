import UIKit

struct PodDetailsConfig {
    let imageUrl: URL?
    let title: String
    let body: String
}

class PodDetailsAssembly {

    static func assemble(with config: PodDetailsConfig) -> (view: UIViewController, output: PodDetailsModuleOutput) {
        let view = PodDetailsViewController()
        let presenter = PodDetailsPresenter()
        let interactor = PodDetailsInteractor()

        view.presenter = presenter
        presenter.view = view
        presenter.config = config
        presenter.interactor = interactor
        interactor.presenter = presenter

        return (view, presenter)
    }
}
