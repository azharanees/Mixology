//
//  FavouritesView.swift
//  Mixology
//
//  Created by Azhar Anees on 2024-03-04.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel = FavoritesViewModel() // Assuming you have a FavoritesViewModel to manage favorite cocktails
    
    var body: some View {
        NavigationView {
            List(viewModel.favoriteCocktails) { cocktail in
                
                HStack {
                    // Display the cocktail information (e.g., name, image, etc.)
                    Text(cocktail.name)
                    // Add more views for other details
                    
                }
            }
            .navigationBarTitle("Favorites")
        }
    }
}



#Preview {
    FavoritesView()
}
