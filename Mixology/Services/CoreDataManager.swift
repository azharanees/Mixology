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


    func saveCustomCocktailRecipe(_ model: CocktailViewModel) -> Bool {
        
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
            return true;
            print("Data Saved")
        } catch {
            return false
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
    
    
    
    func saveFavCocktailRecipe(_ model: Cocktail) {
        
        let context = container.viewContext
        let newObject = FavouriteRecipeModel(context: context)
            
        newObject.id = model.id
            newObject.name = model.name
            newObject.desc = model.description
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
    
    func fetchFavRecipes() -> [FavouriteRecipeModel] {
          let context = container.viewContext
          let fetchRequest: NSFetchRequest<FavouriteRecipeModel> = FavouriteRecipeModel.fetchRequest()
          
          do {
              let recipes = try context.fetch(fetchRequest)
              return recipes
          } catch {
              print("Failed to fetch custom recipes: \(error)")
              return []
          }
      }
    
    
    func deleteFavCocktail(_ model: Cocktail) {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<FavouriteRecipeModel> = FavouriteRecipeModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", model.name)
        
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
    
    func isCocktailFavourite(_ name: String) -> Bool {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<FavouriteRecipeModel> = FavouriteRecipeModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Error checking if cocktail is favorite: \(error)")
            return false
        }
    }
  func fetchSettings() -> [Settings] {
        let context = container.viewContext
        let request: NSFetchRequest<Settings> = Settings.fetchRequest()
        do {
            let settings = try context.fetch(request)
            return settings
        } catch {
            print("Failed to fetch settings: \(error)")
            return []
        }

    }
    
    func saveSettings(_ model: SettingsViewModel){
        let context = container.viewContext
        let newObject = Settings(context: context)
        newObject.enableNotification = model.enableNotifications
        newObject.dateTime = model.selectedDateTime
        saveContext(viewContext: context)

    }
    
    func updateSettings(_ model: SettingsViewModel) {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<Settings> = Settings.fetchRequest()
        do {
            let settings = try context.fetch(fetchRequest)
            if let existingSettings = settings.first {
                existingSettings.enableNotification = model.enableNotifications
                existingSettings.dateTime = model.selectedDateTime
                saveContext(viewContext: context)
                
            } else {
                saveSettings(model)
            }
        } catch {
            fatalError("Failed to update settings: \(error)")
        }
    }
    
    func saveContext(viewContext: NSManagedObjectContext) {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                fatalError("Failed to save Core Data context: \(error)")
            }
        }
    }

}
