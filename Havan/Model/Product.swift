//
//  Product.swift
//  Havan
//
//  Created by Eduardo on 23/05/23.
//

import Foundation

struct Product: Codable, Equatable {
    let id: Int
    var brand: String?
    let name: String
    var price: String?
    var priceSign: String?
    var currency: String?
    var imageLink: String?
    var description: String?
    var rating: Double?
    var category: String?
    var productType: String?
    var isFavorite: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case brand
        case name
        case price
        case priceSign = "price_sign"
        case currency
        case imageLink = "image_link"
        case description
        case rating
        case category
        case productType = "product_type"
        case isFavorite
    }
}

extension Product {
    var completePrice: String {
        let label = "\(priceSign ?? "") \(String(describing: price ?? "")) \(String(describing: currency ?? ""))"
        
        if label.allSatisfy({ $0.isWhitespace }) {
            return "Unavailable"
        } else {
            return label
        }
    }
    
    var formattedName: String {
        return name.removeExtraSpaces()
    }
    
}
