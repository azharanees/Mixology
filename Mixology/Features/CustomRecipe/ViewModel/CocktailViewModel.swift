//
//  CocktailViewModel.swift
//  Mixology
//
//  Created by Shashi Dev Shrestha on 2024-03-04.
//

import Foundation
import CoreData

class CocktailViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var desc = ""
    @Published var strength = ""
    @Published var difficulty = ""
    @Published var ingredients = ""
    @Published var image = ""
    
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    func saveCocktail() {
        coreDataManager.saveCustomCocktailRecipe(CustomRecipeModel.self, modelName: "CustomRecipeModel")
    }

    
    /*func saveCocktail() {
        do {
             let context = CoreDataManager.shared.persistentContainer.viewContext
             guard let entity = NSEntityDescription.entity(forEntityName: "CustomRecipeModel", in: context) else {
                 print("Failed to retrieve entity description")
                 return
             }

            let newCocktail = CustomRecipeModel(entity: entity, insertInto: context)
             newCocktail.id = UUID().uuidString
             newCocktail.name = name
             newCocktail.desc = desc
             newCocktail.strength = strength
             newCocktail.difficulty = difficulty
             newCocktail.ingredients = ingredients
             newCocktail.image = image

             try context.save()
         } catch {
             print("Error saving cocktail: \(error)")
         }
    }*/

}
