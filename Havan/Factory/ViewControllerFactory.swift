//
//  ViewControllerFactory.swift
//  Havan
//
//  Created by Eduardo on 23/05/23.
//

import Foundation

public class ViewControllerFactory {
    internal var viewModelFactory: ViewModelFactory

    init(viewModelFactory: ViewModelFactory) {
        self.viewModelFactory = viewModelFactory
    }
    
    func makeListViewController(coordinator: Coordinator) -> ListViewController {
        let viewModel = viewModelFactory.makeListViewModel(coordinator: coordinator)
        return ListViewController(contentView: ListView(), viewModel: viewModel)
    }
    
    func makeDetailViewController(coordinator: Coordinator, product: Product) -> DetailViewController {
        let viewModel = viewModelFactory.makeDetailViewModel(coordinator: coordinator, product: product)
        return DetailViewController(contentView: DetailView(), viewModel: viewModel)
    }

    func makeFavoriteViewController(coordinator: Coordinator) -> FavoriteViewController {
        let viewModel = viewModelFactory.makeFavoriteViewModel(coordinator: coordinator)
        return FavoriteViewController(contentView: FavoriteView(), viewModel: viewModel)
    }
}

