import UIKit

private struct Appearance {
    static let background: UIColor = .systemGray
}

final class APODsDatePickerViewController: UIViewController {

    var presenter: APODsDatePickerViewOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Appearance.background
        addSubviews()
        makeConstraints()
        presenter.viewDidLoad()
    }

    private func addSubviews() {
    }

    private func makeConstraints() {
    }


    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.viewDidDisappear()
    }
}

extension APODsDatePickerViewController: APODsDatePickerViewInput {

}
