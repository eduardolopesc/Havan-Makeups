//
//  FavoriteViewController.swift
//  Havan
//
//  Created by Eduardo on 24/05/23.
//

import Foundation
import UIKit

class FavoriteViewController: UIViewController {
    private let contentView: FavoriteViewProtocol
    private var viewModel: FavoriteViewModelProtocol

    init(contentView: FavoriteViewProtocol, viewModel: FavoriteViewModelProtocol) {
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
        setTitle("Favorites")
        bindViewModelActions()
        bindViewActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchFavorites()
    }
    
    private func bindViewModelActions() {
        viewModel.reloadView = { [weak self] products in
            self?.contentView.reloadView(with: products)
        }
    }
    
    private func bindViewActions() {
        contentView.didTapCell = { [weak self] product in
            self?.viewModel.showDetail(product: product)
        }
    }
    
    private func setTitle(_ title: String) {
        self.title = title
    }
}
