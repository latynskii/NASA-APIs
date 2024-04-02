import UIKit

private struct Appearance {
    static let backgroundColor: UIColor = .white
}

final class APODsViewController: UIViewController {

    var presenter: APODsViewOutput!

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        makeConstraints()
        presenter.viewDidLoad()
        view.backgroundColor = Appearance.backgroundColor
        title = "NASA APODs"
    }

    private func addSubviews() {
    }

    private func makeConstraints() {
    }

    deinit {
        presenter.viewDidDeInited()
    }
}

extension APODsViewController: APODsViewInput {

}
