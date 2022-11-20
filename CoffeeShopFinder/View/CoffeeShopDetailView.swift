//
//  CoffeeShopDetailView.swift
//  CoffeeShopFinder
//
//  Created by Rizal Muhammad on 19/11/22.
//

import SwiftUI

struct CoffeeShopDetailView: View {
    //MARK: -PROPERTIES
    let coffeeShopDetails: CoffeeShopModel
    
    
    //MARK: -BODY
    var body: some View {
        ZStack{
            LinearGradient(colors: [.white, .brown], startPoint: .topTrailing , endPoint: .bottomLeading)
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                Image(coffeeShopDetails.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 270)
                    .clipShape(Circle())
                    .overlay{
                        ZStack {
                            Circle()
                                .opacity(0.7)
                            VStack {
                                Image(systemName: "person.crop.circle.fill.badge.plus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60)
                                    .symbolRenderingMode(.multicolor)
                                    .foregroundColor(.blue)
                                    
                                
                                Text(coffeeShopDetails.name)
                                    .bold()
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                            }
                            .font(.system(.title, design: .rounded))
                            
                        }
                    }
                
                Text(coffeeShopDetails.review)
                    .multilineTextAlignment(.center)
                    .font(.system(.title2, design: .rounded))
                    .foregroundColor(.blue)
                    .padding()
                
                HStack(alignment: .center){
                    ZStack{
                        Circle()
                            .fill(.gray)
                            .frame(width: 35)
                        Image(systemName: "pin")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15)
                            .foregroundColor(.red)
                    }
                    
                    Text(coffeeShopDetails.location)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                    
                }
                
                Spacer()
            }//: VSTACK
            .padding()
        }
    }
}

//MARK: -PREVIEW
struct CoffeeShopDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeShopDetailView(coffeeShopDetails: CoffeeShopModel(
            image: "bojaeatery",
            name: "Boja Eatery",
            location: "Jl. Sumatera No. 21, Kota Bandung",
            review: "The food is delicious, cooked just right.  Friendly service.  Cozy atmosphere with floral decorations.  There is a ~robot~ that sends the dish.  Prices are reasonable for a restaurant of its class"))
    }
}
