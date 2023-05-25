//
//  ListView.swift
//  Havan
//
//  Created by Eduardo on 23/05/23.
//

import Foundation
import UIKit

class ListView: UIView, ListViewProtocol {
    
    var didTapNumericButton: (() -> Void)?
    var didTapAlphabeticButton: (() -> Void)?
    var didTapClearButton: (() -> Void)?
    var didTapCell: ((Product) -> Void)?
    
    private var products: [Product] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 24.0
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        view.startAnimating()
        return view
    }()
    
    private lazy var filterBar: FilterBarView = {
        let bar = FilterBarView()
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    private lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)
        tb.dataSource = self
        tb.delegate = self
        tb.backgroundColor = .clear
        return tb
    }()
    
    private lazy var backgroundView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "Havan")
        view.alpha = 0.3
        return view
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
        bindSubViewActions()
    }

    private func buildViewHierarchy() {
        addSubview(backgroundView)
        addSubview(stackView)
        addSubview(activityIndicator)
        stackView.addArrangedSubview(filterBar)
        stackView.addArrangedSubview(tableView)
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func bindSubViewActions() {
        
        filterBar.didTapNumericButton = { [weak self] in
            self?.didTapNumericButton?()
        }
        
        filterBar.didTapAlphabeticButton = { [weak self] in
            self?.didTapAlphabeticButton?()
        }
        
        filterBar.didTapClearButton = { [weak self] in
            self?.didTapClearButton?()
        }
    }
    
    private func stopLoading() {
        activityIndicator.stopAnimating()
    }
    
    func reloadView(with products: [Product]) {
        self.products = products
        stopLoading()
    }

}

extension ListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell else {
            return UITableViewCell()
        }

        let product = products[indexPath.row]
        cell.configureView(with: product)
        cell.backgroundColor = UIColor.clear

        return cell
    }
}

extension ListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedProduct = products[indexPath.row]
        didTapCell?(selectedProduct)
    }
}
