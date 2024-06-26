//
//  HomeView.swift
//  Mixology
//
//  Created by Azhar Anees on 2024-02-12.
//

import SwiftUI
import MapKit


struct HomeView: View {
    @State private var searchText = ""
    @ObservedObject var viewModel = HomeViewModel()
    @State private var selectedCategory: String?
    @State private var selectedSortCriteria: HomeViewModel.SortCriteria  = .name
    @State private var isPickerExpanded = false
    @State private var isNavigateToListView = false
    @State private var landmarks: [Landmark] = [Landmark]()
    @State private var tapped: Bool = false
    @ObservedObject var locationManager = LocationManager()
    @State private var filteredCocktails: [Cocktail] = []

    
    private func getNearByLandmarks() {
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "bar"
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let response = response {
                
                let mapItems = response.mapItems
                self.landmarks = mapItems.map {
                    Landmark(placemark: $0.placemark)
                }
                
            }
            
        }
        
    }
    func calculateOffset() -> CGFloat {
            
            if self.landmarks.count > 0 && !self.tapped {
                return UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.height / 4
            }
            else if self.tapped {
                return 100
            } else {
                return UIScreen.main.bounds.size.height
            }
        }
    


       var body: some View {
           let cocktails = viewModel.cocktailDetails
           let recommendCocktails = viewModel.randomCocktailDetails
           TabView {
               NavigationView {
                   VStack {
                       NavigationLink(destination: ListView(cocktails: filteredCocktails), isActive: $isNavigateToListView) { EmptyView() }
                       SearchBar(text: $searchText, searchName: selectedCategory ?? "Margarita", isNavigateToListView: $isNavigateToListView)
                       
                       Spacer()
                       
                           .onChange(of: searchText) { searchText in
                               if searchText.isEmpty {
                                   filteredCocktails = viewModel.cocktailDetails
                               } else {
                                   filteredCocktails = viewModel.cocktailDetails.filter { $0.name.lowercased().contains(searchText.lowercased()) }
                               }
                           }
                   
                       ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                               ForEach(viewModel.iconButtons, id: \.self) { item in
                                   IconButton(item: item){
                                       selectedCategory = item.drinkName
                                       viewModel.filterByCategory(filter: item.drinkName)

                                   }
                               }

                            }
                           .padding(.bottom)
                        }
                       Spacer()
                       
                       
                       HStack{

                           Picker(selection: $selectedSortCriteria, label: Text(isPickerExpanded ? "Sort by: \(selectedSortCriteria == .name ? "Name" : "Strength")" : "Sort by")) {
                               Text("Name").tag(HomeViewModel.SortCriteria.name)
                               Text("Strength").tag(HomeViewModel.SortCriteria.strength)
                           }
                           .pickerStyle(MenuPickerStyle())
                           .padding(.horizontal)
                           .background(Color(.systemBackground))
                           .clipShape(RoundedRectangle(cornerRadius: 8))
                           .shadow(radius: 1)
                           .foregroundColor(.red)
                           .onChange(of: selectedSortCriteria) { newSortCriteria in
                               viewModel.sortDrinks(by: newSortCriteria)
                           }
                           Spacer()

                       }
                       

                       
                       ScrollView(.vertical,showsIndicators: false) {
                           
                           VStack(alignment: .leading) {
                               Text("Most Popular")
                                             .font(.headline)
                                             .multilineTextAlignment(.center)
                                             .padding(.bottom, 5)
                                             .padding(.leading, 20)

                               ScrollView(.horizontal, showsIndicators: false) {
                                   LazyHStack {
                                       ForEach(cocktails) { cocktail in
                                               CardView(cocktail: cocktail)
                                                   .frame(width: 200)
                                       }
                                   }
                                   .padding(.horizontal)
                               }
                           }.padding(.top,15).onAppear {
                               self.selectedCategory = "Cocktail"
                               viewModel.filterByCategory(filter: "cocktail")
                           }

                            
                           Spacer()

                       
                           VStack(alignment: .leading) {
                               Text("For You")
                                             .font(.headline)
                                             .padding(.bottom, 5)
                                             .padding(.leading, 20)

                               ScrollView(.horizontal, showsIndicators: false) {
                                   HStack {
                                       ForEach(recommendCocktails) { cocktail in
                                           CardView(cocktail: cocktail, singleItem: true)
                                       }
                                   }
                               }
                           }.padding(.top,15)
                           
                           
                       }
                       
                   }
                   .padding()
               }.tabItem {
                   Label("Home", systemImage: "house.fill")
               }
               
               VStack{
                   CustomRecipeListView(viewModel: CocktailViewModel(coreDataManager: CoreDataManager.shared))
               }.tabItem {
                   Label("Your Cocktails", systemImage: "wineglass")
               }
               VStack{
                   FavoritesView(viewModel: FavoritesViewModel(coreDataManager: CoreDataManager.shared))
               }.tabItem {
                   Label("Favourites", systemImage: "star.fill")
               }
               VStack{
                   SettingsView(viewModel: SettingsViewModel())
               }.tabItem {
                   Label("Settings", systemImage: "gear")
               }
               VStack{
                   MapView(landmarks: landmarks).onAppear{
                       self.getNearByLandmarks()
                   }
                   PlacesListView(landmarks: self.landmarks) {
                               // on tap
                               self.tapped.toggle()
                           }.animation(.spring())
                    
                        
               }.tabItem {
                   Label("Places", systemImage: "map")
               }
           }
       }
}
struct IconButton: View {
    var item: IconButtonItem
    var action: () -> Void


    var body: some View {
        Button(action: {
            
            self.action()

        }) {
            VStack {
                
                Image(systemName: item.imageName)
                    .foregroundColor(item.color)
                    .imageScale(.large)
                    .padding(3)
                
                Text(item.drinkName)
                    .font(.caption)
                    .foregroundColor(.primary)
            }
        }
    }
}

struct IconButtonItem: Identifiable, Hashable {
    var id = UUID()
    var imageName: String
    var color: Color
    var drinkName: String
}

struct SearchBar: View {
    @Binding var text: String
     var searchName: String
    @Binding var isNavigateToListView: Bool
        var body: some View {
        HStack {
            TextField(searchName, text: $text)
                .padding(10)
                .frame(width: 300)
                .background(Color(.systemGray5))
                .cornerRadius(8)

            Button(action: {
                isNavigateToListView = true
            }) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
            }
            .padding(.trailing, 8)
            .opacity(text.isEmpty ? 0 : 1)
            .animation(.easeInOut)
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    var cocktail: Cocktail
    var singleItem : Bool = false

    var body: some View {
        NavigationLink(destination: DetailsView(cocktail: cocktail)) {
            ZStack(alignment: .bottomLeading) {
                AsyncImage(url: URL(string: cocktail.image)) { phase in
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
                            .frame(height: 150)
                            .clipped()
                            .cornerRadius(10)
                    default:
                        ProgressView()
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(cocktail.name)
                        .font(.headline)
                        .foregroundColor(.white) // Text color over the image background
                        .padding(.horizontal, 10) // Padding for the text
                    
                    Text(cocktail.description)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                }
                .padding(.vertical, 10) // Padding for the entire text backdrop
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.black.opacity(0.5)) // Semi-transparent black background
                )
                
            }
            .frame(height: 150) // Adjust the total card height as needed
            .background(Color.white) // Background color for the card itself
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(.vertical, 5)
            .frame(width: singleItem ? 400 : nil) // Conditional modifier for frame width
        }
    }
}

struct HCardView: View {
    var cocktail: Cocktail

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(cocktail.name)
                .font(.headline)

            Text(cocktail.description)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .frame(height: 150)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.vertical, 5)
    }
}


#Preview {
    HomeView()
}
