//
//  APODCustomDateCell.swift
//  NASA-APIs
//
//  Created by Eduard on 19.04.2024.
//

import UIKit

private struct Appearance {
    static let cellImage: UIImage = .calender
    static let selectedCellImage: UIImage = .calender.withTintColor(.white, renderingMode: .alwaysTemplate)
    static let pickedDateLabelFont: UIFont = .init(name: "Apple SD Gothic Neo Bold", size: 10) ?? .systemFont(ofSize: 10)
}

final class APODCustomDateCell: UICollectionViewCell {
    static let identifier = "APODCustomDateCell"

    private lazy var image: UIImageView = {
        $0.image = Appearance.cellImage
        return $0
    }(UIImageView(frame: .zero))

    private lazy var pickedDateLabelFrom: UILabel = {
        $0.textColor = .white
        $0.font = Appearance.pickedDateLabelFont
        return $0
    }(UILabel())

    private lazy var pickedDateLabelUntil: UILabel = {
        $0.textColor = .white
        $0.font = Appearance.pickedDateLabelFont
        return $0
    }(UILabel())

    private lazy var separatorView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        return view
    }()

    private lazy var mainStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 2
        $0.distribution = .equalSpacing
        $0.alignment = .center
        return $0
    }(UIStackView(frame: .zero))

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
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
            $0.size.equalTo(24)
            $0.centerX.centerY.equalToSuperview()
        }
    }

    func selectDates(from: String?, until: String?) {
        contentView.addSubview(mainStackView)
        [
            image,
            pickedDateLabelFrom,
            separatorView,
            pickedDateLabelUntil].forEach { mainStackView.addArrangedSubview($0) }
        setPickedConstrains()
        pickedDateLabelFrom.text = from
        pickedDateLabelUntil.text = until
        contentView.backgroundColor = .black
        image.image = Appearance.selectedCellImage
        image.tintColor = .white
    }

    func unselectDates() {
        pickedDateLabelFrom.text = nil
        pickedDateLabelUntil.text = nil

        mainStackView.removeFromSuperview()
        contentView.addSubview(image)
        contentView.backgroundColor = .white
        image.image = Appearance.cellImage
        setupConstrains()
    }

    func setPickedConstrains() {
        image.snp.removeConstraints()
        separatorView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(1)
        }
        mainStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
        mainStackView.setCustomSpacing(4, after: image)
        mainStackView.setCustomSpacing(2, after: pickedDateLabelFrom)
        mainStackView.setCustomSpacing(2, after: separatorView)
    }
}
