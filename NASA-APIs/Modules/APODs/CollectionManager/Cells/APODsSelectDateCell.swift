
import UIKit

private struct Appearance {
    static let titleFont: UIFont = .init(name: "Apple SD Gothic Neo Bold", size: 13) ?? .systemFont(ofSize: 13)
    static let titleColor: UIColor = .black
    static let selectedTitleColor: UIColor = .white
}

final class APODsSelectDateCell: UICollectionViewCell {

    static let identifier = "APODsSelectDateCell"

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Appearance.titleFont
        label.textColor = Appearance.titleColor
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        addSubviews()
        setupConstrains()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        unselectCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        contentView.addSubview(titleLabel)
    }

    private func setupConstrains() {
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(12)
        }
    }

    private func updateConstrains() { // update for selected
        titleLabel.snp.remakeConstraints {
            $0.edges.equalToSuperview().inset(isSelected ? 20 : 12)
        }
        contentView.layoutIfNeeded()
    }

    func setup(title: String, isSelected: Bool = false) {
        titleLabel.text = title
        ( isSelected ? selectCell() : unselectCell() )
    }

    private func selectCell() {
        self.contentView.backgroundColor = .black
        self.titleLabel.textColor = Appearance.selectedTitleColor
    }

    private func unselectCell() {
        self.contentView.backgroundColor = .white
        self.titleLabel.textColor = Appearance.titleColor
    }
}
