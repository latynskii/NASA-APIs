private struct Appearance {
    static let titleFont: UIFont = .init(name: "Apple SD Gothic Neo Bold", size: 28) ?? .systemFont(ofSize: 28)
    static let titleColor: UIColor = .black
}

import UIKit

final class APODsCollectionHeaderView: UICollectionReusableView {
    static let identifier = "APODsCollectionHeaderView"
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = Appearance.titleFont
        label.textColor = Appearance.titleColor
        label.textAlignment = .left
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(title)
    }

    private func setupConstrains() {
        title.snp.makeConstraints {
            let insets: UIEdgeInsets = .init(top: 20, left: 0, bottom: 0, right: 0)
            $0.edges.equalToSuperview().inset(insets)
        }
    }

    func setup(title: String?) {
        self.title.text = title
    }
}
