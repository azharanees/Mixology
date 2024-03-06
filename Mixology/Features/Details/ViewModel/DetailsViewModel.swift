//
//  DetailsViewModel.swift
//  Mixology
//
//  Created by Azhar Anees on 2024-03-05.
//

import Foundation
class DetailsViewModel : ObservableObject {
    
    let apiManager = ApiClient.shared
    @Published var cocktailDetails: Cocktail
    private let coreDataManager: CoreDataManager

    init() {
        self.coreDataManager = CoreDataManager.shared
        self.cocktailDetails = Cocktail(id: "", name: "", description: "", strength: "", difficulty: "", ingredients: "", image: "")
    }
    

    
    func addToFavourite(){
        coreDataManager.saveFavCocktailRecipe(cocktailDetails)

    }
    func fetchDetails(drinkId:String){
        apiManager.fetchDrinkById(filter: drinkId){
            (result:Result<DrinkList, Error>) in
            switch result {
            case .success(let cocktailList):
                print(cocktailList)
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
                        self.cocktailDetails = Cocktail(
                            id: cocktailList.drinks[0].idDrink, name: cocktailList.drinks[0].strDrink, description:cocktailList.drinks[0].strInstructions! , strength: "", difficulty: "", ingredients: "", image: cocktailList.drinks[0].strDrinkThumb)
                    }
                case .failure(let error):
                    print("Error fetching cocktail for id 2: \(error.localizedDescription)")
                    
                }
            }
        }
        
}
