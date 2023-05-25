//
//  ProductService.swift
//  Havan
//
//  Created by Eduardo on 23/05/23.
//

import Foundation
import Alamofire

class ProductService: ProductServiceProtocol {
    func searchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        let url = "https://makeup-api.herokuapp.com/api/v1/products.json"
        
        AF.request(url, parameters: nil)
            .validate()
            .responseDecodable(of: [Product].self) { response in
                switch response.result {
                case .success(let products):
                    completion(.success(products))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
