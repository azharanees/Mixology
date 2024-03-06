//
//  FavouritesView.swift
//  Mixology
//
//  Created by Azhar Anees on 2024-03-04.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel = FavoritesViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.favoriteCocktails) { cocktail in
                
                HStack {
                    Text(cocktail.name)
                }
            }
            .navigationBarTitle("Favorites")
        }
    }
}



#Preview {
    FavoritesView()
}
