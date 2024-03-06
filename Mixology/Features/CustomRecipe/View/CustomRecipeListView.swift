//
//  CustomRecipeListView.swift
//  Mixology
//
//  Created by Shashi Dev Shrestha on 2024-03-05.
//

import Foundation
import SwiftUI

struct CustomRecipeListView: View {
    
    @ObservedObject var viewModel: CocktailViewModel

      init(viewModel: CocktailViewModel) {
          self.viewModel = viewModel
      }
    
   // let viewModel = CocktailViewModel(coreDataManager: CoreDataManager.shared)


        var body: some View {
            NavigationView {
                List(viewModel.fetchSavedCocktail()) { cocktail in

                      VStack(alignment: .leading) {
                          Spacer()
                          Text(cocktail.name ?? "").font(.headline).fontWeight(.semibold).lineLimit(1)
                          Text(cocktail.desc ?? "" .trimmingCharacters(in: .whitespacesAndNewlines)).font(.caption).fontWeight(.light).lineLimit(1).padding(.top, 3.0)
                          Spacer()
                      }.padding(8.0)
                      Spacer()
                }
                .navigationTitle("Custom Cocktails")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: CustomReceipeView(viewModel: viewModel)) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        
    }
}

#Preview {
    CustomRecipeListView(viewModel: CocktailViewModel(coreDataManager: CoreDataManager.shared))
}

