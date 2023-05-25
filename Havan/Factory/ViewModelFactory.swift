//
//  ViewModelFactory.swift
//  Havan
//
//  Created by Eduardo on 23/05/23.
//

import Foundation

final class ViewModelFactory {
    
    private let productService = ProductService()
    private let imageService = ImageService()
    private let coreDataManager = CoreDataManager()
    
    func makeListViewModel(coordinator: Coordinator) -> ListViewModelProtocol {
        let viewModel = ListViewModel(service: productService, coordinator: coordinator)
        return viewModel
    }
    
    func makeDetailViewModel(coordinator: Coordinator, product: Product) -> DetailViewModel {
        let viewModel = DetailViewModel(coordinator: coordinator, product: product, coreDataManager: coreDataManager, service: imageService)
        return viewModel
    }

    func makeFavoriteViewModel(coordinator: Coordinator) -> FavoriteViewModelProtocol {
        let viewModel = FavoriteViewModel(coordinator: coordinator, coreDataManager: coreDataManager)
        return viewModel
    }
}
