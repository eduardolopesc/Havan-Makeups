//
//  ListViewModelProtocol.swift
//  Havan
//
//  Created by Eduardo on 24/05/23.
//

protocol ListViewModelProtocol {
    var reloadView: (([Product]) -> Void)? { get set }
    var products: [Product] { get } 
    func fetchProducts()
    func sortByPrice()
    func sortByName()
    func clearSort()
    func showFavorite()
    func showDetail(product: Product)
}
