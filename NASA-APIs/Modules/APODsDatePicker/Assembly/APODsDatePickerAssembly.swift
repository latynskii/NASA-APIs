import UIKit

class APODsDatePickerAssembly {

    static func assemble() -> (view: UIViewController, output: APODsDatePickerModuleOutput) {
        let view = APODsDatePickerViewController()
        let presenter = APODsDatePickerPresenter()
        let interactor = APODsDatePickerInteractor()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter

        return (view, presenter)
    }

}
