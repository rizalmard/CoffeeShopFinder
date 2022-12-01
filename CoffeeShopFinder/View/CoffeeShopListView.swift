//
//  CoffeeShopListView.swift
//  CoffeeShopFinder
//
//  Created by Rizal Muhammad on 19/11/22.
//

import SwiftUI
import ActivityView

struct CoffeeShopListView: View {
    //MARK: -PROPERTIES
    
    @State private var searchCoffeeShop = ""
    @State var coffeeShop = CoffeeShopProvider.all()
    
    private var coffeeShopSearchResult: [CoffeeShopModel] {
        let results = CoffeeShopProvider.all()
        
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
            List {
                ForEach(coffeeShopSearchResult) { result in
                    ZStack(alignment: .leading) {
                        NavigationLink(destination: CoffeeShopDetailView(coffeeShopDetails: result)) {
                            EmptyView()
                        }
                        .opacity(0)
                        CoffeeShopRow(result: result)
                    }
                }
                .onDelete { indexSet in
                    coffeeShop.remove(atOffsets: indexSet)
                }
                .listRowSeparator(.hidden)
            }//: LIST
//            .searchable(
//                text: $searchCoffeeShop,
//                placement: .navigationBarDrawer(displayMode: .always),
//                prompt: "Search coffeeshop"
//            ) {
//                ForEach(suggestCoffeeShop) { shop in
//                    Text("Looking for \(shop.name)?")
//                        .searchCompletion(shop.name)
//                }
//
//            }
        }//: NAVIGATIONSTACK
    }
}

//MARK: -PREVIEW
struct CoffeeShopListView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeShopListView()
    }
}

//MARK: -COFFEESHOWROW
struct CoffeeShopRow: View {
    @State var result: CoffeeShopModel
    @State var isShowingAlert: Bool = false
    @State private var sharedView: ActivityItem?
    var body: some View {
        HStack(alignment: .top) {
            Image(result.image)
                .resizable()
                .scaledToFit()
                .cornerRadius(20)
                .frame(width: 150, height: .infinity)
            
            VStack(alignment: .listRowSeparatorLeading, spacing: 10){
                Text("\(result.name)")
                    .bold()
                    .font(.title2)
                
                Text("\(result.location)")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(.gray)
                
                Text("Rating: 4/5")
                    .font(.system(size: 13, weight: .regular, design: .rounded))
                    .foregroundColor(.gray)
                
                if result.isFavorite {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.yellow)
                        .padding(.vertical)
                }
                
            }
            .alert("Not yet available",
                   isPresented: $isShowingAlert) {
                Button {} label: {
                    Text("OK")
                }
            } message: {
                Text("Sorry, this feature is not available yet")
            }
        }//: HSTACK
        .swipeActions(edge: .leading, allowsFullSwipe: false) {
            Button {
                result.isFavorite.toggle()
            } label: {
                Image(systemName: result.isFavorite ? "heart.slash.fill" : "heart.fill")
            }
            .tint(.green)

            Button {
                sharedView = ActivityItem(items: "CoffeeShop with title: \(result.name) will be shared!!!")
            } label: {
                Image(systemName: "square.and.arrow.up")
            }
            .tint(.indigo)
        }
        .contextMenu {
            Button {
                isShowingAlert = true
            } label: {
                HStack() {
                    Text("Pin this location")
                    Image(systemName: "pin")
                }
            }
            
            Button {
                result.isFavorite.toggle()
            } label: {
                HStack {
                    Text(result.isFavorite ? "Remove from favorite" : "Mark as favorite")
                    Image(systemName: result.isFavorite ? "heart.slash" : "heart")
                }
            }
            
            Button {
                sharedView = ActivityItem(items: "Articel with title: \(result.name) will be shared!!!")
            } label: {
                HStack {
                    Text("Share")
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
        .activitySheet($sharedView)
    }
}
