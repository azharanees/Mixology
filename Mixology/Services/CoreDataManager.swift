//
//  CoreDataManager.swift
//  Mixology
//
//  Created by Shashi Dev Shrestha on 2024-03-04.
//

import Foundation
import CoreData
import Combine

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private let container: NSPersistentContainer

    
    private init() {
        container = NSPersistentContainer(name: "Mixology")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }


    func saveCustomCocktailRecipe(_ model: CocktailViewModel) {
        
        let context = container.viewContext
        let newObject = CustomRecipeModel(context: context)
        
        newObject.id = model.id
        newObject.name = model.name
        newObject.desc = model.desc
        newObject.strength = model.strength
        newObject.difficulty = model.difficulty
        newObject.ingredients = model.ingredients
        newObject.isFavourite = model.isFavourite
        
        do {
            try context.save()
            print("Data Saved")
        } catch {
            print("Failed to save context: \(error)")
        }
    }
    
    func fetchCustomRecipes() -> [CustomRecipeModel] {
          let context = container.viewContext
          let fetchRequest: NSFetchRequest<CustomRecipeModel> = CustomRecipeModel.fetchRequest()
          
          do {
              let recipes = try context.fetch(fetchRequest)
              return recipes
          } catch {
              print("Failed to fetch custom recipes: \(error)")
              return []
          }
      }
    
    
    func deleteCustomCocktail(withID id: UUID) {
          let context = container.viewContext
          let fetchRequest: NSFetchRequest<CustomRecipeModel> = CustomRecipeModel.fetchRequest()
          fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
          
              do {
                  let cocktails = try context.fetch(fetchRequest)
                  for cocktail in cocktails {
                      context.delete(cocktail)
                  }
                  try context.save()
                  print("Cocktail deleted")
              } catch {
                  print("Failed to delete cocktail: \(error)")
              }
          
      }
    
}
