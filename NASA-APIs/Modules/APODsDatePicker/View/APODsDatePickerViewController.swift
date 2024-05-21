import UIKit

private struct Appearance {
    static let background: UIColor = .imagePickerBackground

    static let titleFont: UIFont = .appleBold(with: 24)

    static let titleColor: UIColor = .black

    static let pickDateButtonColor: UIColor = .black
    static let pickDateButtonTitleColor: UIColor = .white
}

final class APODsDatePickerViewController: UIViewController {

    var presenter: APODsDatePickerViewOutput!

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Appearance.titleFont
        label.textColor = Appearance.titleColor
        label.text = "Выбрать дату"
        return label
    }()

    private lazy var closeButton: CorneredButtonView = {
        let button = CorneredButtonView(with: UIImage(systemName: "xmark"))
        return button
    }()

    private lazy var fromDateView: PickDateView = {
        let view = PickDateView(with: .init(title: "От", date: "20.04.2024"))
        return view
    }()

    private lazy var untilDateView: PickDateView = {
        let view = PickDateView(with: .init(title: "До", date: "20.04.2024"))
        return view
    }()

    private lazy var pickDateButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Appearance.pickDateButtonColor
        button.setTitleColor(Appearance.pickDateButtonTitleColor, for: .normal)
        button.layer.cornerRadius = 10
        button.setTitle("Применить", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Appearance.background
        addSubviews()
        makeConstraints()
        presenter.viewDidLoad()
    }

    private func addSubviews() {
        [titleLabel, closeButton, fromDateView, untilDateView, pickDateButton].forEach { view.addSubview($0) }
    }

    private func makeConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(32)
            $0.trailing.lessThanOrEqualTo(closeButton).offset(4)
        }

        closeButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.trailing.equalToSuperview().inset(16)
        }

        fromDateView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        untilDateView.snp.makeConstraints {
            $0.top.equalTo(fromDateView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        pickDateButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(untilDateView.snp.height)
            $0.bottom.equalToSuperview().inset(48)
        }
    }


    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.viewDidDisappear()
    }
}

extension APODsDatePickerViewController: APODsDatePickerViewInput {

}
