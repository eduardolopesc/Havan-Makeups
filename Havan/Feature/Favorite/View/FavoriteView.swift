//
//  FavoriteView.swift
//  Havan
//
//  Created by Eduardo on 24/05/23.
//

import Foundation
import UIKit

class FavoriteView: UIView, FavoriteViewProtocol {
    
    var didTapCell: ((Product) -> Void)?
    
    private var products: [Product] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)
        tb.dataSource = self
        tb.delegate = self
        return tb
    }()
    
    private lazy var emptyStateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.text = "No favorites yet."
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
        addSubview(tableView)
        addSubview(emptyStateLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            emptyStateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func handleEmptyState(_ products: [Product]) {
        if products.isEmpty {
            emptyStateLabel.isHidden = false
        } else {
            emptyStateLabel.isHidden = true
        }
    }
    
    func reloadView(with products: [Product]) {
        handleEmptyState(products)
        self.products = products
    }
}

extension FavoriteView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell

        let product = products[indexPath.row]
        cell.configureView(with: product)

        return cell
    }
}

extension FavoriteView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedProduct = products[indexPath.row]
        didTapCell?(selectedProduct)
    }
}
