//
//  ProductServiceProtocol.swift
//  Havan
//
//  Created by Eduardo on 23/05/23.
//

protocol ProductServiceProtocol {
    func searchProducts(completion: @escaping (Result<[Product], Error>) -> Void)
}
