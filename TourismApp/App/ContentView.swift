//
//  ContentView.swift
//  TourismApp
//
//  Created by Aria Pratomo on 16/02/22.
//

import SwiftUIX
import SwiftUI
import Tourism
import Core


struct ContentView: View {
    @State var selectedTabIndex = 0
    let router : Router
    let favRouter: Router
    let favoritePresenter: TourismListFavoritePresenter
    @EnvironmentObject var homePresenter: TourismListPresenter
    
    
    private let tabBarImageNames = ["globe.americas", "star.square.fill", "person"]
    
    @State var imageData: Data?
    @State var shouldShowImagePicker = false
    
    var body: some View {
        
        GeometryReader { proxy in
            ZStack {
                Spacer()
                VStack(spacing: 0) {
                    
                    switch selectedTabIndex {
                    case 0:
                        HomeView(homeRouter: router,  presenter: homePresenter)
                    case 1:
                        NavigationView {
                            FavoriteView(favoriteRouter: router, presenter: favoritePresenter).navigationTitle("Favorite")
                        }
                        
                    case 2: AboutView()
                    default:
                        NavigationView {
                            VStack {
                                Text("\(tabBarImageNames[selectedTabIndex])")
                                Spacer()
                            }
                            .navigationTitle("\(tabBarImageNames[selectedTabIndex])")
                        }
                    }
                    
                    Divider()
                    HStack {
                        ForEach(0..<3, id: \.self) { num in
                            HStack {
                                Button(action: {
                                    self.selectedTabIndex = num
                                }, label: {
                                    Spacer()
                                    if num == 1 {
                                        Image(systemName: tabBarImageNames[num])
                                            .foregroundColor(Color.red)
                                            .font(.system(size: 44, weight: .semibold))
                                    } else {
                                        Image(systemName: tabBarImageNames[num])
                                            .foregroundColor(selectedTabIndex == num ? .black : .init(white: 0.7))
                                    }
                                    
                                    Spacer()
                                })
                            }.font(.system(size: 24, weight: .semibold))
                        }
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 12)
                    .padding(.bottom, proxy.safeAreaInsets.bottom)
                }
                .edgesIgnoringSafeArea(.bottom)
            }
        }
        
    }
}


