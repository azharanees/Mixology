//
//  CocktailViewModel.swift
//  Mixology
//
//  Created by Shashi Dev Shrestha on 2024-03-04.
//

import Foundation
import CoreData
import Combine

class CocktailViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var desc = ""
    @Published var strength = ""
    @Published var difficulty = ""
    @Published var ingredients = ""
    @Published var isFavourite = false
    @Published var id = UUID()

    
    private let coreDataManager: CoreDataManager
    @Published var isDeleted: Bool = false // New property to track deletion state


    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    func saveCocktail() {
        coreDataManager.saveCustomCocktailRecipe(self)
        resetForm()
    }
    
    func fetchSavedCocktail()->[CustomRecipeModel]{
        return coreDataManager.fetchCustomRecipes()
    }
    
    func deleteCocktail(withID id: UUID) {
        coreDataManager.deleteCustomCocktail(withID: id)
        isDeleted = true
     
    }
    
    func resetForm() {
        name = ""
        desc = ""
        strength = ""
        difficulty = ""
        ingredients = ""
        id = UUID()

    }

}
