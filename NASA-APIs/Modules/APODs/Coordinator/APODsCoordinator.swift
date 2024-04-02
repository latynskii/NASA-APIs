
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
            self?.moduleClosed?()
        }
        push(view: module.view)
    }
}

private extension APODsCoordinator {
    func push(view: UIViewController) {
        guard let navigationVC = presentedView?.navigationController else { return }
        view.navigationItem.largeTitleDisplayMode = .never
        navigationVC.pushViewController(view, animated: true)
    }
}


