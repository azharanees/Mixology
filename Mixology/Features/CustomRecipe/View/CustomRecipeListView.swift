import SwiftUI

struct CustomRecipeListView: View {
    
    @ObservedObject var viewModel: CocktailViewModel

    init(viewModel: CocktailViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            List(viewModel.fetchSavedCocktail()) { cocktail in
                if let unwrappedID = cocktail.id {
                    CocktailListRow(cocktail: cocktail, onDelete: {
                        viewModel.deleteCocktail(withID: unwrappedID)
                    })
                }
            }
            .navigationTitle("Custom Cocktails")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: CustomReceipeView(viewModel: viewModel)) {
                        Image(systemName: "plus")
                    }
                }
            }
            .onReceive(viewModel.$isDeleted) { isDeleted in
                if isDeleted {
                    viewModel.isDeleted = false
                }
            }

        }
    }
}

struct CocktailListRow: View {
    let cocktail: CustomRecipeModel
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
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
        .padding(8.0)
        .padding(.horizontal)
        .listRowInsets(EdgeInsets())
        .background(Color.white)
    }
}

struct CustomRecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        CustomRecipeListView(viewModel: CocktailViewModel(coreDataManager: CoreDataManager.shared))
    }
}
