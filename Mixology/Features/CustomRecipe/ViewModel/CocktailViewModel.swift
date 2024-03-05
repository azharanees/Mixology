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
    @Published var isFavourite = false
    @Published var id = UUID()

    
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    func saveCocktail() {
        coreDataManager.saveCustomCocktailRecipe(self)
    }
    
    func fetchSavedCocktail()->[CustomRecipeModel]{
        return coreDataManager.fetchCustomRecipes()
    }

}
