//
//  CustomReceipeView.swift
//  Mixology
//
//  Created by Shashi Dev Shrestha on 2024-03-04.
//

import Foundation
import SwiftUI

    struct CustomReceipeView: View {
        
        @ObservedObject var viewModel: CocktailViewModel
        
        init(viewModel: CocktailViewModel) {
            self.viewModel = viewModel
        }

        var body: some View {
            NavigationView {
                VStack {
                    CustomRecipeCardView {
                        VStack(alignment: .leading) {
                            Text("Cocktail Details")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.bottom, 8)
                            
                            TextField("Name", text: $viewModel.name)
                            TextField("Description", text: $viewModel.desc)
                            TextField("Strength", text: $viewModel.strength)
                            TextField("Difficulty", text: $viewModel.difficulty)
                            TextField("Ingredients", text: $viewModel.ingredients)
                        }
                        .padding()
                    }
                    .padding()
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.saveCocktail()
                    }) {
                        Text("Save")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isSaveDisabled ? Color.gray : Color.blue)
                            .cornerRadius(12)
                    }
                    .padding()
                    .disabled(isSaveDisabled)
                }
                .navigationTitle("New Cocktail")
            }
        }
        
        private var isSaveDisabled: Bool {
             viewModel.name.isEmpty || viewModel.desc.isEmpty || viewModel.strength.isEmpty || viewModel.difficulty.isEmpty || viewModel.ingredients.isEmpty
         }
        
    }

    struct CustomRecipeCardView<Content: View>: View {
        let content: Content
        
        init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }
        
        var body: some View {
            content
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 4)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CocktailViewModel(coreDataManager: CoreDataManager.shared)
        return CustomReceipeView(viewModel: viewModel)
    }
}


