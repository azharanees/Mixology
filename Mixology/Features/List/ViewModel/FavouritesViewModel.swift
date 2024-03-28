//
//  FavouritesViewModel.swift
//  Mixology
//
//  Created by Azhar Anees on 2024-03-04.
//

import Foundation
import CoreData

import SwiftUI

class FavoritesViewModel: ObservableObject {
    @Published var favoriteCocktails: [Cocktail] = []
    
    private let coreDataManager: CoreDataManager

    func toggleFavorite(_ cocktail: Cocktail) {
        if let index = favoriteCocktails.firstIndex(where: { $0.id == cocktail.id }) {
            favoriteCocktails.remove(at: index)
        } else {
            favoriteCocktails.append(cocktail)
        }
    }

    func isFavorite(_ cocktail: Cocktail) -> Bool {
        return favoriteCocktails.contains { $0.id == cocktail.id }
    }
    
    func fetchSavedCocktail()->[FavouriteRecipeModel]{
        
        return coreDataManager.fetchFavRecipes()
    }
    func fetchSavedCocktail2()->Void{
        
        favoriteCocktails = []
        
        coreDataManager.fetchFavRecipes().forEach { drink in
            favoriteCocktails.append(Cocktail(
                id: drink.id!, name: drink.name!, description: drink.description, strength: drink.strength!, difficulty: drink.difficulty!, ingredients: drink.ingredients!, image: drink.name!
            
            ))
        }
        
    }

    func deleteCocktail(withID id: UUID) {
        coreDataManager.deleteCustomCocktail(withID: id)     
    }

    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
        //let demoCocktails: [Cocktail] = []

        //favoriteCocktails = Array(demoCocktails.prefix(2))
    }
}
