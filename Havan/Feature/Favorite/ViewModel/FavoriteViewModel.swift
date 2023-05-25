//
//  FavoriteViewModel.swift
//  Havan
//
//  Created by Eduardo on 24/05/23.
//

import Foundation
import CoreData

class FavoriteViewModel: FavoriteViewModelProtocol {
    private let coordinator: Coordinator
    private let coreDataManager: CoreDataManager
    var reloadView: (([Product]) -> Void)?

    var products: [Product] = [] {
        didSet {
            reloadView?(products)
        }
    }
    
    init(coordinator: Coordinator, coreDataManager: CoreDataManager) {
        self.coordinator = coordinator
        self.coreDataManager = coreDataManager
    }
    
    func fetchFavorites() {
        let favoriteProductEntities = coreDataManager.fetchFavoriteProductEntities()
        products = favoriteProductEntities.map { entity in
            return Product(id: Int(entity.id),
                           brand: entity.brand,
                           name: entity.name ?? "",
                           price: entity.price,
                           priceSign: entity.priceSign,
                           currency: entity.currency,
                           imageLink: entity.imageLink ?? "",
                           description: entity.descriptionText,
                           rating: entity.rating,
                           category: entity.category,
                           productType: entity.productType,
                           isFavorite: true
            )
        }
    }
    
    func showDetail(product: Product) {
        coordinator.showDetail(product: product)
    }
}
