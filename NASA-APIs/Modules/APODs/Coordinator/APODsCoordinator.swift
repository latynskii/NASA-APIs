import UIKit

final class APODsCoordinator: BaseCoordinatorProtocol {
    var moduleClosed: (() -> Void)?

    private weak var presentedView: UIViewController?

    init(with presentedView: UIViewController?) {
        self.presentedView = presentedView
    }

    func start() {
        let module = APODsAssembly.assemble()
        let input = module.module
        module.module.onFinished = { [weak self] in
            module.view.dismiss(animated: true)
            self?.moduleClosed?()
        }
        module.module.onDatePicker = { [weak self] in
            let config = PODsDatePickerConfig(
                fromDate: input.selectedCustomDates?.fromDate,
                untilDate: input.selectedCustomDates?.toDate
            )
            self?.showDatePickerView(
                for: module.view,
                with: config,
                onModuleFinished: { [weak input] result in
                    input?.setCustomDates(result)
                }
            )
        }
        present(presentedView: presentedView, presentingView: module.view)
    }

    func showDatePickerView(
        for view: UIViewController?,
        with config: PODsDatePickerConfig,
        onModuleFinished: @escaping (APODsDatePickerModuleOutputResult?) -> Void
    ) {
        var module = APODsDatePickerAssembly.assemble(with: config)
        module.view.modalPresentationStyle = .pageSheet
        if let sheet = module.view.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        module.output.onFinished = { result in
            module.view.dismiss(animated: true) {
                onModuleFinished(result)
            }
        }
        view?.present(module.view, animated: true)
    }
}


