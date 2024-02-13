//
//  CategoryListData.swift
//  Mixology
//
//  Created by Shashi Dev Shrestha on 2024-02-13.
//

import Foundation


struct CategoryListData : Decodable{
    let drinks: [DrinkCategory]

}

struct DrinkCategory: Decodable {
    let strCategory: String
}
