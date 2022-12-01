//
//  MainView.swift
//  CoffeeShopFinder
//
//  Created by Rizal Muhammad on 19/11/22.
//

import SwiftUI

struct MainView: View {
    // MARK: - PROPERTIES
    @State private var selectedTab: Tabs = .browse
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                CoffeeShopListView()
                    .listStyle(.plain)
                    .tabItem {
                        Image(systemName: "square.grid.2x2")
                        Text("Browse")
                    }
                    .tag(Tabs.browse)
                    
                
                VStack {
                    Text("watch".uppercased())
                        .font(.system(.largeTitle, design: .rounded))
                    
                    Button {
                        selectedTab = Tabs.profile
                    } label: {
                        Text("Show Profile")
                            .font(.system(.headline, design: .rounded))
                            .padding()
                            .foregroundColor(.white)
                            .background(.indigo)
                            .cornerRadius(10)
                            .padding()
                    }
                    
                }//: VStack
                .tabItem {
                    Image(systemName: "play.rectangle")
                    Text("Watch")
                }
                .tag(Tabs.watch)
                
                Text("loans".uppercased())
                    .font(.system(.largeTitle, design: .rounded))
                    .tabItem {
                        Image(systemName: "rectangle.and.text.magnifyingglass")
                        Text("Loans")
                    }
                    .tag(Tabs.loans)
                
                Text("profile".uppercased())
                    .font(.system(.largeTitle, design: .rounded))
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }
                    .tag(Tabs.profile)
            }//: TABVIEW
            .tint(.purple)
            .navigationTitle(selectedTab.rawValue.capitalized)
        }//: NAVIGATION
    }
}

// MARK: - PREVIEW
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

// MARK: - ENUM
enum Tabs: String {
    case browse
    case watch
    case loans
    case profile
}
