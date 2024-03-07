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
                    CocktailListRow(cocktail: cocktail) {
                        viewModel.deleteCocktail(withID: unwrappedID)
                    }
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
    @State private var showAlert = false

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
            Image(systemName: "trash")
                .foregroundColor(.red)
                .onTapGesture {
                    showAlert = true
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Confirm Delete"), message: Text("Are you sure you want to delete the cocktail?"), primaryButton: .destructive(Text("Yes"), action: {
                        onDelete()
                    }), secondaryButton: .cancel())
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
