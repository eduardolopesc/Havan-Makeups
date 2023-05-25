//
//  DetailView.swift
//  Havan
//
//  Created by Eduardo on 23/05/23.
//

import Foundation
import UIKit

class DetailView: UIView, DetailViewProtocol {
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        view.startAnimating()
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var brandLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var productTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var noImageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.text = "No image found."
        label.alpha = 0.3
        label.isHidden = true
        return label
    }()
        
    init() {
        super.init(frame: .zero)

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
        addSubview(activityIndicator)
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(brandLabel)
        addSubview(priceLabel)
        addSubview(ratingLabel)
        addSubview(categoryLabel)
        addSubview(productTypeLabel)
        addSubview(noImageLabel)
    }
        
    private func addConstraints() {
        let margin: CGFloat = 16
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: margin),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: margin),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            
            brandLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            brandLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            brandLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            
            priceLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            
            ratingLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            ratingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            ratingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            
            categoryLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 8),
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            
            productTypeLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8),
            productTypeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            productTypeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            productTypeLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -margin),
            
            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            
            noImageLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            noImageLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }
        
    func updateView(entity: DetailViewEntity) {
        nameLabel.text = entity.nameLabel
        brandLabel.text = entity.brandLabel
        priceLabel.text = entity.priceLabel
        ratingLabel.text = entity.ratingLabel
        categoryLabel.text = entity.categoryLabel
        productTypeLabel.text = entity.productTypeLabel
    }
    
    func updateImage(_ image: UIImage?) {
        activityIndicator.stopAnimating()
        if let image = image {
            imageView.alpha = 1
            imageView.contentMode = .scaleAspectFill
            imageView.image = image
            noImageLabel.isHidden = true
        } else {
            imageView.alpha = 0.08
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(systemName: "photo")
            noImageLabel.isHidden = false
        }
    }
}
