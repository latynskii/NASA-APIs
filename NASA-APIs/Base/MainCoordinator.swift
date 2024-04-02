
import UIKit

final class MainCoordinator: BaseCoordinatorProtocol {
    var moduleClosed: (() -> Void)?

    private weak var rootView: UINavigationController?

    private var childCoordinators: [BaseCoordinatorProtocol] = []

    private var window: UIWindow?

    init(with window:  UIWindow?) {
        self.window = window
    }
    
    func start() {
        var apiListModule =  APIListAssembly.assemble()
        let rootNavigationController = UINavigationController(rootViewController: apiListModule.view)
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
        self.rootView = rootNavigationController

        apiListModule.output.onOpenAPODs = { [weak self] in
            self?.openAPODs()
        }
    }
    
    func openAPODs() {
        let coordinator = APODsCoordinator(with: rootView?.visibleViewController)
        coordinator.moduleClosed = { [weak self] in
            self?.childCoordinators.removeAll()
        }
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
