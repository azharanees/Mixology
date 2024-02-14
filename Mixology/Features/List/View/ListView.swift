
//
//  ListView.swift
//  Mixology
//
//  Created by Azhar Anees on 2024-02-13.
//

import SwiftUI

struct ListView: View {

    var cocktails: [Cocktail]

    var body: some View {
        
           NavigationView {
               List(cocktails) { cocktail in
                       CardView(cocktail: cocktail)
                           .frame(height: 150) // Adjust the card height as needed
               }
           }
       }
}

