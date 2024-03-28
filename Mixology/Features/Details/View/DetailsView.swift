//
//  DetailsView.swift
//  Mixology
//
//  Created by Azhar Anees on 2024-03-05.
//

import SwiftUI

struct DetailsView: View {
    
    @ObservedObject var viewModel:DetailsViewModel
    var cocktail :Cocktail
    init(cocktail: Cocktail) {
        self.cocktail = cocktail
        viewModel = DetailsViewModel()
    }

    
    var body: some View {
    
    
        VStack {
            Text(viewModel.cocktailDetails.name)
                .font(.title)
                .padding()
            
            AsyncImage(url: URL(string: viewModel.cocktailDetails.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 150) // Adjust the image height as needed
                        .clipped()
                        .cornerRadius(10) // Apply corner radius to the image
                case .failure:
                    // Handle error or show a placeholder image
                    Image(systemName: "photo") // Placeholder image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 300)
                        .clipped()
                        .cornerRadius(10)
                default:
                    ProgressView()
                }
            }
            
            Text(viewModel.cocktailDetails.description)
                .font(.body)
                .padding()
            
            Button(action: {
                // Handle adding to favorites
                viewModel.toggleFavorite()
            }) {
                Image(systemName: viewModel.cocktailDetails.isFavourite ? "heart.fill" : "heart")
                    .foregroundColor(.red)
                    .font(.title)
            }
            .padding()
            
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
        }.onAppear {
            viewModel.fetchDetails(drinkId: cocktail.id)
        }
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
