//
//  CocktailModel.swift
//  Mixology
//
//  Created by Azhar Anees on 2024-02-12.
//

import Foundation
struct Cocktail: Identifiable {
    var id = UUID()
    var name: String
    var description: String
    var strength:String
    var difficulty:String
    var ingredients:String
}
