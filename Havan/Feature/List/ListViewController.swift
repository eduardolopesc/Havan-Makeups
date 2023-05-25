//
//  ListViewController.swift
//  Havan
//
//  Created by Eduardo on 23/05/23.
//

import Foundation
import UIKit

class ListViewController: UIViewController {
    private let contentView: ListViewProtocol
    private var viewModel: ListViewModelProtocol

    init(contentView: ListViewProtocol, viewModel: ListViewModelProtocol) {
        self.contentView = contentView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupNavigationBar()
        bindViewModelActions()
        bindViewActions()
        viewModel.fetchProducts()
    }
    
    private func bindViewModelActions() {
        viewModel.reloadView = { [weak self] products in
            self?.contentView.reloadView(with: products)
        }
    }
    
    private func bindViewActions() {
        contentView.didTapAlphabeticButton = { [weak self] in
            self?.viewModel.sortByName()
        }
        
        contentView.didTapNumericButton = { [weak self] in
            self?.viewModel.sortByPrice()
        }
        
        contentView.didTapClearButton = { [weak self] in
            self?.viewModel.clearSort()
        }
        
        contentView.didTapCell = { [weak self] product in
            self?.viewModel.showDetail(product: product)
        }
    }
    
    private func setupNavigationBar() {
        self.title = "Havan Makeups"
        let favoriteButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(favoriteButtonTapped))
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    @objc private func favoriteButtonTapped() {
        viewModel.showFavorite()
    }
    
}
