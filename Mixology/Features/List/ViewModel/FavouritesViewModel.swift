//
//  FavouritesViewModel.swift
//  Mixology
//
//  Created by Azhar Anees on 2024-03-04.
//

import Foundation


import SwiftUI

class FavoritesViewModel: ObservableObject {
    @Published var favoriteCocktails: [Cocktail] = []

    // Function to toggle the favorite status of a cocktail
    func toggleFavorite(_ cocktail: Cocktail) {
        if let index = favoriteCocktails.firstIndex(where: { $0.id == cocktail.id }) {
            // Cocktail is in favorites, remove it
            favoriteCocktails.remove(at: index)
        } else {
            // Cocktail is not in favorites, add it
            favoriteCocktails.append(cocktail)
        }
    }

    // Function to check if a cocktail is in favorites
    func isFavorite(_ cocktail: Cocktail) -> Bool {
        return favoriteCocktails.contains { $0.id == cocktail.id }
    }

    // Demo data - replace this with actual data fetching logic
    init() {
        let demoCocktails: [Cocktail] = [
            Cocktail(
                id: "drink.idDrink",
                name: "drink.strDrink",
                description: "",
                strength: "",
                difficulty: "",
                ingredients: "",
                image: "drink.strDrinkThumb"
            ),
            Cocktail(id: "1", name: "Margarita", description: "Classic margarita", strength: "s", difficulty: "d", ingredients: "a",  image: "margarita_image"),
            // Add more demo cocktails as needed
        ]

        // Assume the first two cocktails are favorites initially
        favoriteCocktails = Array(demoCocktails.prefix(2))
    }
}
