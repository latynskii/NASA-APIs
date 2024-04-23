
import UIKit

private struct Appearance {
    static let textColor: UIColor = .black
    static let titleFont: UIFont = .init(name: "Apple SD Gothic Neo Bold", size: 24) ?? .systemFont(ofSize: 24)
}

protocol BottomBarViewDelegate: AnyObject {
    func didLeftButtonTapped()
    func didRightButtonTapped()
}

final class BottomBarView: UIView {

    weak var delegate: BottomBarViewDelegate?
    
    private lazy var leftButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(.init(systemName: "chevron.left"), for: .normal)
        button.tintColor = Appearance.textColor
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var titleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Appearance.textColor
        label.font = Appearance.titleFont
        label.textAlignment = .center
        return label
    }()

    private lazy var rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(.init(systemName: "suit.heart"), for: .normal)
        button.tintColor = Appearance.textColor
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var mainContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .bottomBarBackground
        view.layer.cornerRadius = 10
        return view
    }()


    override var intrinsicContentSize: CGSize {
        return .init(width: .zero, height: 70)
    }

    required init(title: String,
         onLeftTapped: @escaping () -> Void,
         onRightTapped: @escaping () -> Void

    ) {
        super.init(frame: .zero)
        titleLabel.text = title
        addSubviews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func leftButtonTapped() {
        delegate?.didLeftButtonTapped()
    }

    @objc private func rightButtonTapped() {
        delegate?.didRightButtonTapped()
    }

    private func addSubviews() {
        addSubview(mainContainerView)
        titleView.addSubview(titleLabel)
        [
            leftButton,
            titleView,
            rightButton
        ].forEach { addSubview($0) }
    }

    private func setupConstrains() {
        mainContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        titleView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(62 + 6 + 4)
            $0.top.bottom.equalToSuperview().inset(4)
        }

        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.leading.trailing.lessThanOrEqualToSuperview()
        }

        leftButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(4)
            $0.trailing.equalTo(titleLabel.snp.leading).offset(-4)
            $0.top.bottom.equalToSuperview().inset(4)
        }

        rightButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(4)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(4)
            $0.top.bottom.equalToSuperview().inset(4)
        }
    }
}
