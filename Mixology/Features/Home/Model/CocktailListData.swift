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
}

struct DrinkList: Codable {
    let drinks: [Drink]
}
