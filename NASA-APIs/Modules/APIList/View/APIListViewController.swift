import UIKit

private struct Appearance {

}

final class APIListViewController: UIViewController {

    var presenter: APIListViewOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        makeConstraints()
        presenter.viewDidLoad()
    }

    private func addSubviews() {
    }

    private func makeConstraints() {
    }
}

extension APIListViewController: APIListViewInput {

}
