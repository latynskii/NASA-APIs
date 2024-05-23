

import UIKit

final class PodDetailImageCell: UITableViewCell {

    static let identifier = "PodDetailImageCell"

    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .gray
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 16
        image.clipsToBounds = true
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .lightGray
        addSubviews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        contentView.addSubview(image)
    }

    private func setupConstrains() {
        image.snp.makeConstraints {
            let edges: UIEdgeInsets = .init(top: 4, left: 4, bottom: 4, right: 4)
            $0.edges.equalToSuperview().inset(edges)
        }
    }

    func setImage(with url: URL?) {
        image.kf.setImage(with: url)
    }
}
