//
//  FavouritesView.swift
//  Mixology
//
//  Created by Azhar Anees on 2024-03-04.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: FavoritesViewModel
    
    
    
    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.favoriteCocktails) { cocktail in
                
                    FavListRow(cocktail: cocktail, onDelete: {
                    })
                
            }.onAppear{
                viewModel.fetchSavedCocktail2()
            }
            .navigationTitle("Favourites")
            
        }
    }
}


struct FavListRow: View {
    let cocktail: Cocktail
    let onDelete: () -> Void

    var body: some View {
        
        NavigationLink(destination:DetailsView(cocktail:Cocktail(
            id: cocktail.id,
            name: "drink.strDrink",
            description: cocktail.description,
            strength: "",
            difficulty: "",
            ingredients: "",
            image: "drink.strDrinkThumb"
        )
)) {
            HStack {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
                VStack(alignment: .leading) {
                    Text(cocktail.name ?? "")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .lineLimit(1)
            
                }

            }
            .padding(10.0)
            .listRowInsets(EdgeInsets())
        .background(Color.white)
        }
    }
}




struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        CustomRecipeListView(viewModel: CocktailViewModel(coreDataManager: CoreDataManager.shared))
    }
}
