//
//  FavoriteProduct+CoreDataProperties.swift
//  
//
//  Created by Eduardo on 24/05/23.
//
//

import Foundation
import CoreData


extension FavoriteProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteProduct> {
        return NSFetchRequest<FavoriteProduct>(entityName: "FavoriteProduct")
    }

    @NSManaged public var id: Int32
    @NSManaged public var brand: String?
    @NSManaged public var name: String?
    @NSManaged public var price: String?
    @NSManaged public var priceSign: String?
    @NSManaged public var currency: String?
    @NSManaged public var imageLink: String?
    @NSManaged public var isFavorite: String?
    @NSManaged public var rating: Double
    @NSManaged public var category: String?
    @NSManaged public var productType: String?
    @NSManaged public var descriptionText: String?

}
