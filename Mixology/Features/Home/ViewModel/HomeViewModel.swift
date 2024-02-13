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

    
    init() {
        fetchIconButtons()
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
         apiManager.filterByCateogry(filter: filter) { (result: Result<DrinkList, Error>) in
             switch result {
             case .success(let cocktailList):
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
             case .failure(let error):
                 print("Error fetching category list: \(error.localizedDescription)")
             }
         }
     }
    
    func getSymbolName(for name: String) -> String {
        switch name {
        case "Ordinary Drink":
            return "mug.fill"
        case "Cocktail":
            return "wineglass.fill"
        case "Shake":
            return "waterbottle.fill"
        case "Other / Unknown":
            return "questionmark.circle"
        case "Cocoa":
            return "cup.and.saucer.fill"
        case "Shot":
            return "flame"
        case "Coffee / Tea":
            return "mug"
        case "Homemade Liqueur":
            return "waterbottle.fill"
        case "Punch / Party Drink":
            return "takeoutbag.and.cup.and.straw.fill"
        case "Beer":
            return "waterbottle"
        case "Soft Drink":
            return "wineglass.fill"
        default:
            return "questionmark.circle"
        }
    }
    
}


       
