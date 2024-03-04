//
//  CoreDataManager.swift
//  Mixology
//
//  Created by Shashi Dev Shrestha on 2024-03-04.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var modelName: String = ""
    
    func saveCustomCocktailRecipe<T: NSManagedObject>(_ model: T.Type, modelName: String) {
        self.modelName = modelName
        let context = persistentContainer.viewContext
        guard let entityName = T.entity().name else { return }
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else { return }
        
        let newObject = T(entity: entity, insertInto: context)
        
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
