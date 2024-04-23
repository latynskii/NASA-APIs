
import UIKit
import Kingfisher

private struct Appearance {
    static let titleFont: UIFont = .init(name: "Apple SD Gothic Neo Bold", size: 15) ?? .systemFont(ofSize: 15)
    static let titleColor: UIColor = .black
    static let selectedTitleColor: UIColor = .white
}

final class MainImageCell: UICollectionViewCell {
    static let identifier = "MainImageCell"
    private lazy var image: UIImageView = {
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .darkGray
        return $0
    }(UIImageView(frame: .zero))

    private lazy var title: UILabel = {
        $0.font = Appearance.titleFont
        $0.textColor = Appearance.titleColor
        $0.numberOfLines = 0
        return $0
    }(UILabel())

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        addSubviews()
        setupConstrains()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        [image, title].forEach { contentView.addSubview($0) }
    }

    private func setupConstrains() {
        image.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
        }

        title.snp.makeConstraints {
            $0.top.equalTo(image.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(4)
        }
    }

    func setImage(with url: URL?) {
        image.kf.setImage(with: url)
    }

    func set(title: String) {
        self.title.text = title
    }
}
