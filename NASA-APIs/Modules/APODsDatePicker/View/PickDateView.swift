
import UIKit

private struct Appearance {
    static let background: UIColor = .white
    static let titleFont: UIFont = .appleRegular(with: 14)
    static let titleColor: UIColor = .black

    static let dateFont: UIFont = .appleBold(with: 14)

    static let selfHeight: CGFloat = 70
    static let cornerRadius: CGFloat = 10
}

struct PickDateViewConfig {
    let title: String
    let date: String?
}

final class PickDateView: UIControl {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Appearance.titleFont
        label.textColor = Appearance.titleColor
        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = Appearance.dateFont
        label.textColor = Appearance.titleColor
        return label
    }()

    override var intrinsicContentSize: CGSize {
        .init(width: 0, height: Appearance.selfHeight)
    }

    init(with config: PickDateViewConfig) {
        super.init(frame: .zero)
        titleLabel.text = config.title
        dateLabel.text = config.date
        layer.cornerRadius = Appearance.cornerRadius
        setUntappedUI()
        addSubviews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        [titleLabel, dateLabel].forEach { addSubview($0) }
    }

    private func setupConstrains() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.trailing.lessThanOrEqualTo(dateLabel).offset(8)
        }

        dateLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
    }

    private func updateUI() {
        (isSelected ? setTappedUI() : setUntappedUI())
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        isSelected = true
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        isSelected = false
    }

    private func setTappedUI() {
        self.backgroundColor = .lightGray
        self.titleLabel.layer.opacity = 0.5
    }

    private func setUntappedUI() {
        self.backgroundColor = Appearance.background
        self.titleLabel.layer.opacity = 1
    }

    override var isSelected: Bool {
        didSet {
            updateUI()
        }
    }

    override var isHighlighted: Bool {
        didSet {
            isSelected = isHighlighted
        }
    }

    func update(with config: PickDateViewConfig) {
        dateLabel.text = config.date
    }
}
