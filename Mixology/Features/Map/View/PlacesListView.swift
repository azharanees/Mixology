//
//  PlacesListView.swift
//  Mixology
//
//  Created by Azhar Anees on 2024-03-27.
//

import SwiftUI

struct PlacesListView: View {
    
    let landmarks: [Landmark]
    var onTap: () -> ()

    
    var body: some View {
        VStack(alignment: .leading) {
                    HStack {
                        EmptyView()
                    }.frame(width: UIScreen.main.bounds.size.width, height: 10)
                        .gesture(TapGesture()
                            .onEnded(self.onTap)
                    )
                    
                    List {
                        
                        ForEach(self.landmarks, id: \.id) { landmark in
                            
                            VStack(alignment: .leading) {
                                Text(landmark.name)
                                    .fontWeight(.bold)
                                
                                Text(landmark.title)
                            }
                        }
                        
                    }.animation(nil)
                    
                }.cornerRadius(10)
            } 
}



