//
//  CocktailListData.swift
//  Mixology
//
//  Created by Shashi Dev Shrestha on 2024-02-13.
//

import Foundation


struct Drink: Codable {
    let strDrink: String
    let strDrinkThumb: String
    let idDrink: String
    var strInstructions: String?

     
}

struct DrinkList: Codable {
    let drinks: [Drink]
}

struct DrinkDetail: Codable{
    var idDrink: String
    var strDrink: String
    var strDrinkAlternate: String?
    var strTags: String
    var strVideo: String?
    var strCategory: String
    var strIBA: String
    var strAlcoholic: String
    var strGlass: String
    var strInstructions: String
    var strInstructionsES: String?
    var strInstructionsDE: String
    var strInstructionsFR: String?
    var strInstructionsIT: String
    var strInstructionsZH_HANS: String?
    var strInstructionsZH_HANT: String?
    var strDrinkThumb: String
    var strIngredient1: String
    var strIngredient2: String
    var strIngredient3: String
    var strIngredient4: String?
    var strIngredient5: String?
    var strIngredient6: String?
    var strIngredient7: String?
    var strIngredient8: String?
    var strIngredient9: String?
    var strIngredient10: String?
    var strIngredient11: String?
    var strIngredient12: String?
    var strIngredient13: String?
    var strIngredient14: String?
    var strIngredient15: String?
    var strMeasure1: String
    var strMeasure2: String
    var strMeasure3: String
    var strMeasure4: String?
    var strMeasure5: String?
    var strMeasure6: String?
    var strMeasure7: String?
    var strMeasure8: String?
    var strMeasure9: String?
    var strMeasure10: String?
    var strMeasure11: String?
    var strMeasure12: String?
    var strMeasure13: String?
    var strMeasure14: String?
    var strMeasure15: String?
    var strImageSource: String
    var strImageAttribution: String
    var strCreativeCommonsConfirmed: String
    var dateModified: String
}
