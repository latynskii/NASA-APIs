
import UIKit

protocol BaseCoordinatorProtocol: AnyObject {
    var moduleClosed: (() -> Void)? { get set }

    func start()
}


extension BaseCoordinatorProtocol {
    func push(view: UIViewController, presentedView: UIViewController?) {
        guard let navigationVC = presentedView?.navigationController else { return }
        view.navigationItem.largeTitleDisplayMode = .never
        navigationVC.pushViewController(view, animated: true)
    }

    func present(presentedView: UIViewController?, presentingView: UIViewController) {
        guard let presentedView = presentedView else { return }
        presentingView.modalPresentationStyle = .fullScreen
        presentingView.modalTransitionStyle = .crossDissolve

        presentedView.present(presentingView, animated: true)
    }
}
