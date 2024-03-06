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
            List(viewModel.fetchSavedCocktail()) { cocktail in
                if let unwrappedID = cocktail.id {
                    FavListRow(cocktail: cocktail, onDelete: {
                        viewModel.deleteCocktail(withID: unwrappedID)
                    })
                }
            }
            .navigationTitle("Favourites")
            
        }
    }
}


struct FavListRow: View {
    let cocktail: FavouriteRecipeModel
    let onDelete: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Spacer()
                Text(cocktail.name ?? "")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                Text(cocktail.desc ?? "")
                    .font(.caption)
                    .fontWeight(.light)
                    .lineLimit(1)
                    .padding(.top, 3.0)
                Spacer()
            }
            Spacer()
            Button(action: onDelete) {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
            }
        }
        .padding(8.0)
        .padding(.horizontal)
        .listRowInsets(EdgeInsets())
        .background(Color.white)
    }
}




struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        CustomRecipeListView(viewModel: CocktailViewModel(coreDataManager: CoreDataManager.shared))
    }
}
