import UIKit
enum PickDateFieldType {
    case from
    case until
}

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
        button.onTap = { [weak self] in
            self?.presenter.closeTapped()
        }
        return button
    }()

    private lazy var fromDateView: PickDateView = {
        let view = PickDateView(action: { [weak self] in
            self?.setPickerBeforeOpening()
            self?.fromClearTF.becomeFirstResponder()
        })
        return view
    }()

    private lazy var untilDateView: PickDateView = {
        let view = PickDateView(action: { [weak self] in
            self?.setPickerBeforeOpening()
            self?.untilClearTF.becomeFirstResponder()
        })
        return view
    }()

    private lazy var fromClearTF: UITextField = {
        let textField = UITextField()
        textField.layer.opacity = 0
        return textField
    }()

    private lazy var untilClearTF: UITextField = {
        let textField = UITextField()
        textField.layer.opacity = 0
        return textField
    }()

    private lazy var pickDateButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Appearance.pickDateButtonColor
        button.setTitleColor(Appearance.pickDateButtonTitleColor, for: .normal)
        button.layer.cornerRadius = 10
        button.setTitle("Применить", for: .normal)
        button.addTarget(self, action: #selector(applyTapped), for: .touchUpInside)
        return button
    }()

    private var fromPicker: UIDatePicker?
    private var untilPicker: UIDatePicker?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Appearance.background
        addSubviews()
        makeConstraints()
        presenter.viewDidLoad()
        setPickers()
    }

    private func addSubviews() {
        [titleLabel, closeButton, fromDateView, untilDateView, pickDateButton, fromClearTF, untilClearTF].forEach { view.addSubview($0) }
    }

    private func setPickers() {
        let pickerFrom = UIDatePicker()
        pickerFrom.preferredDatePickerStyle = .inline
        fromClearTF.inputView = pickerFrom
        pickerFrom.addTarget(self, action: #selector(fromPickerValueChanged), for: .valueChanged)
        fromPicker = pickerFrom

        let pickerUntil = UIDatePicker()
        pickerUntil.preferredDatePickerStyle = .inline
        untilClearTF.inputView = pickerUntil
        pickerUntil.addTarget(self, action: #selector(untilPickerValueChanged), for: .valueChanged)
        untilPicker = pickerUntil
    }

    @objc private func fromPickerValueChanged(picker: UIDatePicker) {
        fromDateView.update(with: .init(title: "От", date: picker.date.simpleFormat()))
        presenter.picked(date: picker.date, type: .from)
    }

    @objc private func untilPickerValueChanged(picker: UIDatePicker) {
        untilDateView.update(with: .init(title: "До", date: picker.date.simpleFormat()))
        presenter.picked(date: picker.date, type: .until)
    }

    @objc private func applyTapped() {
        presenter.applyTapped()
    }

    private func setPickerBeforeOpening() {
        if let date = self.presenter.untilDatePicked {
            self.fromPicker?.maximumDate = date
        }
        if let date = self.presenter.fromDatePicked {
            self.untilPicker?.minimumDate = date
        }
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

        fromClearTF.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(fromDateView.snp.height)
        }

        untilClearTF.snp.makeConstraints {
            $0.top.equalTo(fromClearTF.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(untilDateView.snp.height)
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.viewDidDisappear()
    }
}

extension APODsDatePickerViewController: APODsDatePickerViewInput {
    func setApplyButton(enabled: Bool) {
        pickDateButton.isEnabled = enabled
        pickDateButton.layer.opacity = enabled ? 1 : 0.5
    }
    
    func set(date: String?, for type: PickDateFieldType) {
        switch type {
        case .from:
            fromDateView.update(with: .init(title: "От", date: date))
        case .until:
            untilDateView.update(with: .init(title: "До", date: date))
        }
    }
}
