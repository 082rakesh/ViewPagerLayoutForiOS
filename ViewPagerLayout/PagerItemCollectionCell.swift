//
//  PagerItemCollectionCell.swift
//  ViewPagerLayout
//
//  Created by rakesh.e.mishra on 05/02/20.
//  Copyright © 2020 rakesh.e.mishra. All rights reserved.
//

import UIKit

class PagerItemCollectionCell: UICollectionViewCell {

    private lazy var itemLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.backgroundColor = .white

        return label
    }()

    private lazy var itemBorder: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .black
        return label
    }()

    var textColor: UIColor = .black {
        didSet {
            itemLabel.textColor = textColor
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(Coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(itemLabel)
        addSubview(itemBorder)
        setupItemLabelConstraints()
        setupItemBorderConstraints()
    }
    
    private func setupItemLabelConstraints() {
        itemLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            itemLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 2.5),
            itemLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0),
            itemLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0),
        ])
    }

    private func setupItemBorderConstraints() {
        itemBorder.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            itemBorder.topAnchor.constraint(equalTo: itemLabel.bottomAnchor, constant: 2.5),
            itemBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0),
            itemBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0),
            itemBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -0.0),
            itemBorder.heightAnchor.constraint(equalToConstant: 2.0)
        ])
    }

    func setupItemLabel(with title: String) {
        itemLabel.text = title
    }
}
