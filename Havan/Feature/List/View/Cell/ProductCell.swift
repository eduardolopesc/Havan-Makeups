//
//  ProductCell.swift
//  Havan
//
//  Created by Eduardo on 23/05/23.
//

import Foundation
import UIKit

class ProductCell: UITableViewCell {
    static let identifier = "ProductCell"

    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        imageView.image = .actions
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var brandLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 6
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .systemGreen
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(brandLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    private func addConstraints() {
        let margin: CGFloat = 16
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin),
            
            brandLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 4),
            brandLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin),
            brandLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin),
            
            descriptionLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configureView(with product: Product) {
        nameLabel.text = product.formattedName
        brandLabel.text = product.brand?.capitalized
        descriptionLabel.text = product.description?.removeHTMLTags()
        priceLabel.text = "Price: \(product.completePrice)"
    }
}
