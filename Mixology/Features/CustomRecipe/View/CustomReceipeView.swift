//
//  CustomReceipeView.swift
//  Mixology
//
//  Created by Shashi Dev Shrestha on 2024-03-04.
//

import SwiftUI
struct CustomReceipeView: View {
    
    @ObservedObject var viewModel: CocktailViewModel
    @State private var errorMessage: String = ""
    @Environment(\.presentationMode) var presentationMode // Access presentation mode
    
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
                               TextEditor(text: $viewModel.desc)
                                    .frame(height: 100) // Set desired height
                                    .cornerRadius(8) // Optional: Add corner radius
                                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.secondary, lineWidth: 1))
                               TextField("Strength", text: $viewModel.strength)
                               .keyboardType(.decimalPad)
                               TextField("Difficulty", text: $viewModel.difficulty)
                               TextField("Ingredients", text: $viewModel.ingredients)                        }
                }
                .padding()
                
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()

                
                Spacer()
                
                Button(action: {
                          if viewModel.validateInputs() {
                              viewModel.saveCocktail()
                              errorMessage = ""
                          } else {
                              errorMessage = "Please fill all fields and ensure Strength is positive numeric."
                          }
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
        .onReceive(viewModel.$savedCocktail) { savedCocktail in
            if let _ = savedCocktail {
                presentationMode.wrappedValue.dismiss() // Dismiss the current view
            }
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
        VStack(spacing: 8) { // Adjust the spacing as needed
            content
        }
        .padding()
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

