//
//  CoreDataManager.swift
//  Havan
//
//  Created by Eduardo on 24/05/23.
//

import Foundation
import CoreData

class CoreDataManager {
    private let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "Havan")
        persistentContainer.loadPersistentStores { (_, error) in
            if let error = error {
                print(error)
            }
        }
    }
    
    private var managedContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        guard managedContext.hasChanges else {
            return
        }
        
        do {
            try managedContext.save()
        } catch {
            print(error)
        }
    }
    
    func createProductEntity() -> FavoriteProduct? {
        guard let entity = NSEntityDescription.entity(forEntityName: "FavoriteProduct", in: managedContext) else {
            return nil
        }
        
        let productEntity = FavoriteProduct(entity: entity, insertInto: managedContext)
        return productEntity
    }
    
    func fetchFavoriteProductEntities(with productID: Int? = nil) -> [FavoriteProduct] {
        let fetchRequest: NSFetchRequest<FavoriteProduct> = FavoriteProduct.fetchRequest()
        if let productID = productID {
            fetchRequest.predicate = NSPredicate(format: "id == %d", productID)
        }
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            return results
        } catch {
            print(error)
            return []
        }
    }
    
    func deleteProductEntity(_ productEntity: FavoriteProduct) {
        managedContext.delete(productEntity)
    }
}
