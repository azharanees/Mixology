//
//  HomeViewModel.swift
//  Mixology
//
//  Created by Azhar Anees on 2024-02-12.
//

import Foundation

class HomeViewModel : ObservableObject {

    
    let apiManager = ApiClient.shared
    @Published var iconButtons: [IconButtonItem] = []
    @Published var cocktailDetails: [Cocktail] = []
    @Published var randomCocktailDetails: [Cocktail] = []
    var searchCache = [String: DrinkList]() // Dictionary for cached data

    
    
    init() {
        fetchIconButtons()
        getRandomDrinks()

    }
    
    func fetchIconButtons() {
        apiManager.fetchCategoryListData { (result: Result<CategoryListData, Error>) in
            switch result {
            case .success(let categoryListData):
                let iconButtonItems = categoryListData.drinks.map { drink in
                    IconButtonItem(id: UUID(), imageName: self.getSymbolName(for : drink.strCategory), color: .red, drinkName: drink.strCategory)
                }
                DispatchQueue.main.async {
                    self.iconButtons = iconButtonItems
                }
            case .failure(let error):
                print("Error fetching category list: \(error.localizedDescription)")
            }
        }
    }
    
    func filterByCategory(filter: String) {
        
        if let cachedList = searchCache[filter] {
            print(cachedList)
            self.populateDrinks(cocktailList: cachedList)
           return
         }
         apiManager.filterByCateogry(filter: filter) { (result: Result<DrinkList, Error>) in
             switch result {
             case .success(let cocktailList):
                 self.searchCache[filter] = cocktailList // Store fetched data in cache
                 self.populateDrinks(cocktailList: cocktailList)
             case .failure(let error):
                 print("Error fetching category list: \(error.localizedDescription)")
             }
         }
     }
    
    func populateDrinks(cocktailList : DrinkList){
        let cocktailCards = cocktailList.drinks.map { drink in
            Cocktail(
                id: drink.idDrink,
                name: drink.strDrink,
                description: "",
                strength: "",
                difficulty: "",
                ingredients: "",
                image: drink.strDrinkThumb
            )
        }
        DispatchQueue.main.async {
            self.cocktailDetails = cocktailCards // Update cocktails property
        }
    }
    
    
    func getRandomDrinks(){
        apiManager.fetchByRandom { (result: Result<DrinkList, Error>) in
            switch result {
            case .success(let randomListData):
                let cocktailCards = randomListData.drinks.map { drink in
                    Cocktail(
                        id: drink.idDrink,
                        name: drink.strDrink,
                        description: "",
                        strength: "",
                        difficulty: "",
                        ingredients: "",
                        image: drink.strDrinkThumb
                    )
                }
                DispatchQueue.main.async {
                    self.randomCocktailDetails = cocktailCards // Update cocktails property
                }
            case .failure(let error):
                print("Error fetching category list: \(error.localizedDescription)")
            }
        }
    }
    
    
    
    func sortDrinks(by criteria: SortCriteria) {
        switch criteria {
        case .name:
            cocktailDetails.sort { $0.name < $1.name }
        case .strength:
            cocktailDetails.sort { $0.id < $1.id }
        }
    }
    
    func getSymbolName(for name: String) -> String {
        switch name {
        case "Ordinary Drink":
            return "mug.fill"
        case "Cocktail":
            return "wineglass.fill"
        case "Shake":
            return "square.3.layers.3d"
        case "Other / Unknown":
            return "questionmark.circle"
        case "Cocoa":
            return "cup.and.saucer.fill"
        case "Shot":
            return "flame"
        case "Coffee / Tea":
            return "mug"
        case "Homemade Liqueur":
            return "homepod.2.fill"
        case "Punch / Party Drink":
            return "takeoutbag.and.cup.and.straw.fill"
        case "Beer":
            return "homepod.fill"
        case "Soft Drink":
            return "wineglass.fill"
        default:
            return "questionmark.circle"
        }
    }
    
    enum SortCriteria {
        case name
        case strength
    }
    
}


       
