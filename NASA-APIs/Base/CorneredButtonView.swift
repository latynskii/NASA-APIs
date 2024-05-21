
import UIKit

private struct Appearance {
    static let viewSideSize: CGFloat = 32
    static let viewCornerRadius: CGFloat = 10
}

final class CorneredButtonView: UIControl {

    private lazy var buttonImage: UIImageView = {
        let image = UIImageView()
        image.tintColor = .black
        return image
    }()

    init(with image: UIImage?) {
        super.init(frame: .zero)
        buttonImage.image = image?.withTintColor(.black, renderingMode: .alwaysTemplate)
        addSubviews()
        setupConstrains()
        self.layer.cornerRadius = Appearance.viewCornerRadius
        updateUI()
    }

    override var intrinsicContentSize: CGSize {
        .init(width: Appearance.viewSideSize, height: Appearance.viewSideSize)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        addSubview(buttonImage)
    }

    private func setupConstrains() {
        buttonImage.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(6)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        isSelected = true
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        isSelected = false
    }

    override var isHighlighted: Bool {
        didSet {
            isSelected = isHighlighted
        }
    }

    override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.33) { [weak self] in
                self?.updateUI()
            }
        }
    }

    private func updateUI() {
        (isSelected ? tappedUI() : untappedUI())
    }

    private func untappedUI() {
        self.backgroundColor = .white
        self.buttonImage.layer.opacity = 1
    }

    private func tappedUI() {
        self.backgroundColor = .lightGray
        self.buttonImage.layer.opacity = 0.5
    }
}
