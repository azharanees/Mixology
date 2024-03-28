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
    
    @Published var savedCocktail: Bool?


    
    private let coreDataManager: CoreDataManager
    @Published var isDeleted: Bool = false // New property to track 


    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    func saveCocktail() {
        let isSaved = coreDataManager.saveCustomCocktailRecipe(self)
        resetForm()
        savedCocktail = isSaved
    }
    
    func fetchSavedCocktail()->[CustomRecipeModel]{
        return coreDataManager.fetchCustomRecipes()
    }
    
    func deleteCocktail(withID id: UUID) {
        coreDataManager.deleteCustomCocktail(withID: id)
        isDeleted = true
     
    }
    
    func validateInputs() -> Bool {
        guard let strengthValue = Double(strength), strengthValue >= 0 else {
            return false
        }
        return !name.isEmpty && !desc.isEmpty 
    }
    
    private func isNumeric(_ value: String) -> Bool {
        return Double(value) != nil
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
