//
//  CoffeeShopListView.swift
//  CoffeeShopFinder
//
//  Created by Rizal Muhammad on 19/11/22.
//

import SwiftUI

struct CoffeeShopListView: View {
    //MARK: -PROPERTIES
    
    @State private var searchCoffeeShop = ""
    
    private var coffeeShopSearchResult: [CoffeeShopModel] {
        let results = CoffeeShopModel.CoffeeShopProvider.all()
        
        if searchCoffeeShop.isEmpty{
            return results
        } else {
            return results.filter {
                $0.name.lowercased().contains(searchCoffeeShop.lowercased()) ||
                $0.name.contains(searchCoffeeShop)
            }
        }
    }
    
    private var suggestCoffeeShop: [CoffeeShopModel] {
        if searchCoffeeShop.isEmpty{
            return []
        } else {
            return coffeeShopSearchResult
        }
    }
    
    //MARK: -BODY
    var body: some View {
        NavigationStack{
            List(coffeeShopSearchResult) { result in
                NavigationLink(destination: {
                    CoffeeShopDetailView(coffeeShopDetails: result)
                }) {
                    HStack(alignment: .top){
                        Image(result.image)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                            .frame(width: 130, height: 130)
                        
                        VStack(alignment: .listRowSeparatorLeading, spacing: 15){
                            Text("\(result.name)")
                                .bold()
                                .font(.title2)
                                
                            Text("\(result.location)")
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                                .foregroundColor(.gray)
                            
                            Text("Rating: 4/5")
                                .font(.system(size: 13, weight: .regular, design: .rounded))
                                .foregroundColor(.gray)
                            
                        }
                    }
                }
            }
            .navigationTitle("Coffeeshop")
            .searchable(
                text: $searchCoffeeShop,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search coffeeshop"
            ) {
                ForEach(suggestCoffeeShop) { shop in
                    Text("Looking for \(shop.name)?")
                        .searchCompletion(shop.name)
                }
            }
        }//: NAVIGATION
    }
}

//MARK: -PREVIEW
struct CoffeeShopListView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeShopListView()
    }
}
