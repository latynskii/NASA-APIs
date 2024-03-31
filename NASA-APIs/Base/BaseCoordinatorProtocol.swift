
import Foundation

protocol BaseCoordinatorProtocol: AnyObject {
    var moduleClosed: (() -> Void)? { get set }

    func start()
}
