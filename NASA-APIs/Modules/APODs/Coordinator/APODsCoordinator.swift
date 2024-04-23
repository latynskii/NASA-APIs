import UIKit

final class APODsCoordinator: BaseCoordinatorProtocol {
    var moduleClosed: (() -> Void)?

    private weak var presentedView: UIViewController?

    init(with presentedView: UIViewController?) {
        self.presentedView = presentedView
    }

    func start() {
        var module = APODsAssembly.assemble()
        module.output.onFinished = { [weak self] in
            module.view.dismiss(animated: true)
            self?.moduleClosed?()
        }
        present(presentedView: presentedView, presentingView: module.view)
    }
}


