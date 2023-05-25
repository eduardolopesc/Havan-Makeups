//
//  DetailViewController.swift
//  Havan
//
//  Created by Eduardo on 23/05/23.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    private let contentView: DetailViewProtocol
    private var viewModel: DetailViewModelProtocol

    init(contentView: DetailViewProtocol, viewModel: DetailViewModelProtocol) {
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
        let viewEntity = viewModel.viewEntity()
        setTitle(viewEntity.nameLabel)
        contentView.updateView(entity: viewEntity)
        setFavorite()
        bindViewModelActions()
    }
    
    private func setTitle(_ title: String) {
        self.title = title
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func bindViewModelActions() {
        viewModel.loadImage = { [weak self] image in
            self?.contentView.updateImage(image)
        }
    }
    
    private func setFavorite() {
        setFavoriteButton(saved: viewModel.product.isFavorite ?? false)
    }
    
    private func setFavoriteButton(saved: Bool) {
        let image = saved ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        let favoriteButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(favoriteButtonTapped))
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    @objc private func favoriteButtonTapped() {
        setFavoriteButton(saved: !(viewModel.product.isFavorite ?? false))
        viewModel.favoriteToggle()
    }
    
}
