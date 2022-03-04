//
//  HomeView.swift
//  TourismApp
//
//  Created by Aria Pratomo on 16/02/22.
//

import SwiftUI
import SDWebImageSwiftUI
import Core
import Tourism

struct HomeView: View {
    
    var homeRouter: Router
    @ObservedObject var presenter: TourismListPresenter
    
    var body: some View {
        NavigationView {
            if presenter.isLoading {
                VStack {
                  Text("Loading...")
                  ActivityIndicator()
                }
            } else {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(self.presenter.list, id: \.id) { tourism in
                             self.detailLinkBuilder(for: tourism) {
                                content(tourism: tourism)
                             }.buttonStyle(.plain)
                        }
                    }
                    .navigationTitle("Tourism App")
                    
                }
            }
            
        }.onAppear {
            if self.presenter.list.count == 0 {
                self.presenter.getList(request: nil)
            }
        }.navigationTitle("Tourism App")
    }
}

extension HomeView {
    
    func content(tourism: TourismDomainModel) -> some View {
        return VStack {
            images(url: tourism.image)
            
            HStack(alignment: .top) {
                titleAndLikes(tourism: tourism)
                Spacer()
                address(address: tourism.address)
            }.padding(.top, 8)
            .padding(.horizontal)
            .padding(.bottom, 16)
        }
    }
    
    func images(url: String) -> some View {
        return WebImage(url: URL(string: url))
            .resizable()
            .scaledToFill()
    }
    
    func titleAndLikes(tourism: TourismDomainModel) -> some View {
        return VStack(alignment: .leading) {
            Text(tourism.name)
                .font(.system(size: 16, weight: .bold))
            HStack {
                Image(systemName: "hand.thumbsup.fill")
                Text("\(tourism.like)".prefix(4))
            }
            
        }
    }
    
    func address(address: String) -> some View {
        return HStack {
            Image(systemName: "location")
                .font(.system(size: 14, weight: .bold))
            Text(address)
                .font(.system(size: 15, weight: .semibold))
        }.foregroundColor(.white)
        .padding(.vertical, 6)
        .padding(.horizontal, 12)
        .background(Color.blue)
        .cornerRadius(16)
    }
}


extension HomeView {
    func detailLinkBuilder<Content: View>(
        for movie: TourismDomainModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        ZStack {
            NavigationLink(destination: homeRouter.makeDetailView(for: movie)) {
                content()
            }
        }
    }
}

