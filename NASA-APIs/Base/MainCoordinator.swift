
import UIKit

final class MainCoordinator: BaseCoordinatorProtocol {
    var moduleClosed: (() -> Void)?
    
    private weak var rootView: UINavigationController?

    private var window: UIWindow?

    init(with window:  UIWindow?) {
        self.window = window
    }

    func start() {
        let apiListModule =  APIListAssembly.assemble()
        let rootNavigationController = UINavigationController(rootViewController: apiListModule.view)
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
        self.rootView = rootNavigationController
    }
}
