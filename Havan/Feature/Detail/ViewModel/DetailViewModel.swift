//
//  DetailViewModel.swift
//  Havan
//
//  Created by Eduardo on 23/05/23.
//

import Foundation
import UIKit

class DetailViewModel: DetailViewModelProtocol {
    private let coordinator: Coordinator
    private let service: ImageServiceProtocol
    private let coreDataManager: CoreDataManager
    var product: Product
    var updateView: (() -> Void)?
    var loadImage: ((UIImage?) -> Void)?
    
    private var productImage: UIImage? {
        didSet {
            loadImage?(productImage)
        }
    }

    init(coordinator: Coordinator, product: Product, coreDataManager: CoreDataManager, service: ImageServiceProtocol) {
        self.coordinator = coordinator
        self.product = product
        self.coreDataManager = coreDataManager
        self.service = service
        checkIsFavorite()
        fetchImage()
    }
    
    private func fetchImage() {
        guard let url = URL(string: product.imageLink ?? "") else {
            return
        }
        service.downloadImage(from: url) { [weak self] result in
            switch result {
            case .success(let image):
                self?.productImage = image
            case .failure(let error):
                self?.productImage = nil
                print(error)
            }
        }
    }
    
    func favoriteToggle() {
        if product.isFavorite ?? false {
            removeProductFromFavorites()
        } else {
            saveProductToFavorite()
        }
    }

    private func saveProductToFavorite() {
        if let productEntity = coreDataManager.createProductEntity() {
            productEntity.id = Int16(product.id)
            productEntity.brand = product.brand
            productEntity.name = product.name
            productEntity.price = product.price
            productEntity.priceSign = product.priceSign
            productEntity.currency = product.currency
            productEntity.imageLink = product.imageLink
            productEntity.descriptionText = product.description
            productEntity.rating = product.rating ?? 0.0
            productEntity.category = product.category
            productEntity.productType = product.productType
            product.isFavorite = true
            coreDataManager.saveContext()
        }
    }
    
    private func removeProductFromFavorites() {
        let productEntities = coreDataManager.fetchFavoriteProductEntities(with: product.id)
        
        for productEntity in productEntities {
            coreDataManager.deleteProductEntity(productEntity)
        }
        product.isFavorite = false
        coreDataManager.saveContext()
    }
    
    private func checkIsFavorite() {
        let productEntities = coreDataManager.fetchFavoriteProductEntities(with: product.id)
        
        if productEntities.isEmpty {
            product.isFavorite = false
        } else {
            product.isFavorite = true
        }
    }
    
    func viewEntity() -> DetailViewEntity {
        return DetailViewEntity(nameLabel: product.name.removeExtraSpaces(),
                                brandLabel: "Brand: \(product.brand?.capitalized ?? "Unavailable")",
                                priceLabel: "Price: \(product.completePrice)",
                                ratingLabel: "Rating: \(product.rating?.description ?? "Unavailable")",
                                categoryLabel: "Category: \(product.category?.capitalized ?? "Unavailable")",
                                productTypeLabel: "Type: \(product.productType?.capitalized ?? "Unavailable")"
        )
    }
}
