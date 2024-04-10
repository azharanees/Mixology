//
//  DetailsView.swift
//  Mixology
//
//  Created by Azhar Anees on 2024-03-05.
//

import SwiftUI

struct DetailsView: View {
    
    @ObservedObject var viewModel: DetailsViewModel
    var cocktail: Cocktail
    
    init(cocktail: Cocktail) {
        self.cocktail = cocktail
        viewModel = DetailsViewModel()
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text(viewModel.cocktailDetails.name)
                .font(.title)
            
            AsyncImage(url: URL(string: viewModel.cocktailDetails.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .clipped()
                        .cornerRadius(10)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                                                .clipped()

                        .cornerRadius(10)
                default:
                    ProgressView()
                }
            }
            
            Text(viewModel.cocktailDetails.description)
                .font(.body)
            
            Button(action: {
                viewModel.toggleFavorite()
            }) {
                Image(systemName: viewModel.cocktailDetails.isFavourite ? "heart.fill" : "heart")
                    .foregroundColor(.red)
                    .font(.title)
            }
            
            Menu {
             
                ShareLink(
                                     item: viewModel.cocktailDetails.name,
                                     subject: Text("Check out this cocktail!"),
                                     message: Text("\(viewModel.cocktailDetails.name) :- \(viewModel.cocktailDetails.description)"),
                                     preview: SharePreview("\(viewModel.cocktailDetails.name)", image: viewModel.cocktailDetails.image)
                                 )
                          

            } label: {
                Image(systemName: "square.and.arrow.up")
                    .foregroundColor(.blue)
                    .font(.title)
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            viewModel.fetchDetails(drinkId: cocktail.id)
        }
        .navigationTitle(viewModel.cocktailDetails.name) // Assuming this is used within a NavigationView
    }
}



#Preview {
        DetailsView(cocktail: Cocktail(
            id: "1",
            name: "drink.strDrink",
            description: "",
            strength: "",
            difficulty: "",
            ingredients: "",
            image: "drink.strDrinkThumb"
        )
)
}
