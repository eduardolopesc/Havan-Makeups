//
//  FavoriteViewModelProtocol.swift
//  Havan
//
//  Created by Eduardo on 25/05/23.
//

protocol FavoriteViewModelProtocol {
    var reloadView: (([Product]) -> Void)? { get set }
    var products: [Product] { get }
    func fetchFavorites()
    func showDetail(product: Product)
}
