//
//  Coordinator.swift
//  Havan
//
//  Created by Eduardo on 23/05/23.
//

import Foundation
import UIKit

class Coordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    let factory = ViewControllerFactory(viewModelFactory: ViewModelFactory())
    
    func start() {
        let viewController = factory.makeListViewController(coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showDetail(product: Product) {
        let viewController = factory.makeDetailViewController(coordinator: self, product: product)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showFavorite() {
        let viewController = factory.makeFavoriteViewController(coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
    }
}
