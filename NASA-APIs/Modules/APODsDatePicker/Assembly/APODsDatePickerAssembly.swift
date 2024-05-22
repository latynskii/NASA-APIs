import UIKit

struct PODsDatePickerConfig {
    let fromDate: Date?
    let untilDate: Date?
}

class APODsDatePickerAssembly {

    static func assemble(with config: PODsDatePickerConfig) -> (view: UIViewController, output: APODsDatePickerModuleOutput) {
        let view = APODsDatePickerViewController()
        let presenter = APODsDatePickerPresenter()
        let interactor = APODsDatePickerInteractor()

        view.presenter = presenter
        presenter.view = view
        presenter.config = config
        presenter.interactor = interactor
        interactor.presenter = presenter

        return (view, presenter)
    }

}
