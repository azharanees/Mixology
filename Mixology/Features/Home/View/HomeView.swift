//
//  HomeView.swift
//  Mixology
//
//  Created by Azhar Anees on 2024-02-12.
//

import SwiftUI


struct HomeView: View {
    @State private var searchText = ""
       @State private var cocktails = [
           Cocktail(name: "Margarita", description: "Classic tequila cocktail", strength: "High", difficulty: "Hard", ingredients: "Tequila"),  Cocktail(name: "Margarita", description: "Classic tequila cocktail", strength: "High", difficulty: "Hard", ingredients: "Tequila"),  Cocktail(name: "Margarita", description: "Classic tequila cocktail", strength: "High", difficulty: "Hard", ingredients: "Tequila"),  Cocktail(name: "Margarita", description: "Classic tequila cocktail", strength: "High", difficulty: "Hard", ingredients: "Tequila"), Cocktail(name: "Margarita", description: "Classic tequila cocktail", strength: "High", difficulty: "Hard", ingredients: "Tequila"), Cocktail(name: "Margarita", description: "Classic tequila cocktail", strength: "High", difficulty: "Hard", ingredients: "Tequila"), Cocktail(name: "Margarita", description: "Classic tequila cocktail", strength: "High", difficulty: "Hard", ingredients: "Tequila"), Cocktail(name: "Margarita", description: "Classic tequila cocktail", strength: "High", difficulty: "Hard", ingredients: "Tequila"),
           // Add more cocktails as needed
       ]
    
    
    private let iconButtons: [IconButtonItem] = [
        IconButtonItem(imageName: "heart.fill", color: .red),
        IconButtonItem(imageName: "star.fill", color: .yellow),IconButtonItem(imageName: "wineglass", color: .yellow),IconButtonItem(imageName: "wineglass", color: .yellow),IconButtonItem(imageName: "wineglass", color: .yellow),IconButtonItem(imageName: "wineglass", color: .yellow),IconButtonItem(imageName: "star.fill", color: .yellow),IconButtonItem(imageName: "star.fill", color: .yellow),IconButtonItem(imageName: "star.fill", color: .yellow),IconButtonItem(imageName: "star.fill", color: .yellow),
        // Add more icon buttons as needed
    ]

       var body: some View {
           VStack {
               SearchBar(text: $searchText)
               Spacer()
               ScrollView(.horizontal, showsIndicators: false) {
                                  HStack {
                                      ForEach(iconButtons, id: \.self) { item in
                                          IconButton(item: item)
                                      }
                                  }
                                  .padding(.horizontal)
                              }
               Spacer()
               
               ScrollView(.vertical,showsIndicators: false) {
                   
                   VStack(alignment: .leading) {
                       Text("Most Popular")
                                     .font(.headline)
                                     .multilineTextAlignment(.center)
                                     .padding(.bottom, 5)
                                     .padding(.leading, 20)

                       ScrollView(.horizontal, showsIndicators: false) {
                           HStack {
                               ForEach(cocktails) { cocktail in
                                   CardView(cocktail: cocktail)
                                       .frame(width: 200) // Adjust the card width as needed
                               }
                           }
                           .padding(.horizontal)
                       }
                   }.padding(.top,15)
                    
                   Spacer()

               
                   VStack(alignment: .leading) {
                       Text("For You")
                                     .font(.headline)
                                     .padding(.bottom, 5)
                                     .padding(.leading, 20)

                       ScrollView(.horizontal, showsIndicators: false) {
                           HStack {
                               ForEach(cocktails) { cocktail in
                                   CardView(cocktail: cocktail)
                                       .frame(width: 200) // Adjust the card width as needed
                               }
                           }
                           .padding(.horizontal)
                       }
                   }.padding(.top,15)
               
                   VStack(alignment: .leading) {
                       Text("Favourites")
                                     .font(.headline)
                                     .padding(.bottom, 5)
                                     .padding(.leading, 20)

                       ScrollView(.horizontal, showsIndicators: false) {
                           HStack {
                               ForEach(cocktails) { cocktail in
                                   CardView(cocktail: cocktail)
                                       .frame(width: 200) // Adjust the card width as needed
                               }
                           }
                           .padding(.horizontal)
                       }
                   }.padding(.top,15)
                   
                   VStack(alignment: .leading) {
                       Text("Underrated")
                                     .font(.headline)
                                     .padding(.bottom, 8)
                                     .padding(.leading, 20)
                       
                                        
                       ScrollView(.horizontal, showsIndicators: false) {
                           HStack {
                               ForEach(cocktails) { cocktail in
                                   CardView(cocktail: cocktail)
                                       .frame(width: 200) // Adjust the card width as needed
                               }
                           }
                           .padding(.horizontal)
                       }
                   } .padding(.top,15)
               }
               
           }
           .padding()
       }
}
struct IconButton: View {
    var item: IconButtonItem

    var body: some View {
        Button(action: {
            // Action for the icon button
        }) {
            Image(systemName: item.imageName)
                .foregroundColor(item.color)
                .imageScale(.large)
                .padding()
        }
    }
}

struct IconButtonItem: Identifiable, Hashable {
    var id = UUID()
    var imageName: String
    var color: Color
}

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search cocktails", text: $text)
                .padding(8)
                .background(Color(.systemGray5))
                .cornerRadius(8)

            Button(action: {
                self.text = ""
            }) {
                Image(systemName: "xmark.circle.fill")
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

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Load image from URL using AsyncImage and set it as the background of the card
            AsyncImage(url: URL(string: "https://hips.hearstapps.com/hmg-prod/images/frozen-blue-moscato-margaritas3-1653174015.jpg")) { phase in
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
