//
//  DetailsView.swift
//  Mixology
//
//  Created by Azhar Anees on 2024-03-05.
//

import SwiftUI

struct DetailsView: View {
    
    @ObservedObject var viewModel:DetailsViewModel
    var cocktailId = "1"

    init(cocktailId: String) {
        print("cocktailID \(cocktailId)")
        self.cocktailId = cocktailId
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
                viewModel.addToFavourite()
                      }) {
                          Image(systemName: viewModel.cocktailDetails.isFavourite ? "heart.fill" : "heart")
                              .foregroundColor(.red)
                              .font(.title)
                      }
                      .padding()
            Spacer()
        }.onAppear {
            viewModel.fetchDetails(drinkId: cocktailId)
        }
    }
}



#Preview {
    DetailsView(cocktailId: "1")
}
