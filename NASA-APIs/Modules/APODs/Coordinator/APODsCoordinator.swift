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
            self?.showDatePickerView(
                for: module.view,
                onModuleFinished: { [weak input]  result in
                    input?.setCustomDates(result)
                }
            )
        }
        present(presentedView: presentedView, presentingView: module.view)
    }

    func showDatePickerView(
        for view: UIViewController?,
        onModuleFinished: @escaping (APODsDatePickerModuleOutputResult) -> Void
    ) {
        var module = APODsDatePickerAssembly.assemble()
        module.view.modalPresentationStyle = .pageSheet
        if let sheet = module.view.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        module.output.onFinished = { result in
            onModuleFinished(result)
        }
        view?.present(module.view, animated: true)
    }
}


