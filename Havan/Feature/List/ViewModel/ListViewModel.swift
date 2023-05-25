//
//  ListViewModel.swift
//  Havan
//
//  Created by Eduardo on 23/05/23.
//

import Foundation

class ListViewModel: ListViewModelProtocol {
    private let coordinator: Coordinator
    private let service: ProductServiceProtocol
    private var sortedByPrice = false
    private var sortedAlphabetically = false
    var reloadView: (([Product]) -> Void)?
    
    var products: [Product] = [] {
        didSet {
            reloadView?(products)
        }
    }
    
    init(service: ProductServiceProtocol, coordinator: Coordinator) {
        self.service = service
        self.coordinator = coordinator
    }

    func fetchProducts() {
        service.searchProducts() { result in
            switch result {
            case .success(let products):
                self.products = products
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func sortProductsByPrice() {
        if sortedByPrice {
            products.sort { Double($0.price ?? "0") ?? 0 > Double($1.price ?? "0") ?? 0 }
        } else {
            products.sort { Double($0.price ?? "0") ?? 0 < Double($1.price ?? "0") ?? 0 }
        }
    }

    private func sortProductsByName() {
        if sortedAlphabetically {
            products.sort { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
        } else {
            products.sort { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedDescending }
        }
    }
    
    func sortByPrice() {
        sortedByPrice.toggle()
        sortProductsByPrice()
    }

    func sortByName() {
        sortedAlphabetically.toggle()
        sortProductsByName()
    }
    
    func clearSort() {
        products.sort { $0.id > $1.id }
    }
    
    func showFavorite() {
        coordinator.showFavorite()
    }
    
    func showDetail(product: Product) {
        coordinator.showDetail(product: product)
    }

}
