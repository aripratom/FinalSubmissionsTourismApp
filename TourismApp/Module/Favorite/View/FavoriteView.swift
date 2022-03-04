//
//  FavoriteView.swift
//  TourismApp
//
//  Created by Aria Pratomo on 16/02/22.
//

import SwiftUI
import SDWebImageSwiftUI
import Tourism

struct FavoriteView: View {
    
    var favoriteRouter: Router
    @ObservedObject var presenter: TourismListFavoritePresenter
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                VStack {
                  Text("Loading...")
                  ActivityIndicator()
                }
            } else {
                if self.presenter.list.count == 0 {
                    VStack {
                        Text("NO FAVORITE PLACE")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }.navigationTitle("Favorite")
                } else {
                    VStack(alignment: .leading) {
                        List {
                            ForEach(self.presenter.list, id: \.id) { tourism in
                                ZStack(alignment: .leading) {
                                    self.detailLinkBuilder(for: tourism) {
                                    }
                                    .opacity(0.0)
                                    .buttonStyle(PlainButtonStyle())
                                
                                    content(tourism: tourism)
                                }.listRowSeparator(.hidden)
                                    .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                                
                            }
                        }.listStyle(PlainListStyle())
                            .refreshable {
                                presenter.getList(request: nil)
                            }
                    }
                    
                }
                
            }
            
        }.onAppear {
            self.presenter.getList(request: nil)
            if self.presenter.list.count == 0 {
                self.presenter.getList(request: nil)
            }
        }
    }
}

extension FavoriteView {
    
    func content(tourism: TourismDomainModel) -> some View {
        return VStack {
            images(url: tourism.image)
            
            HStack(alignment: .top) {
                titleAndLikes(tourism: tourism)
                Spacer()
                address(address: tourism.address)
            }
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
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

extension FavoriteView {
    func detailLinkBuilder<Content: View>(
        for movie: TourismDomainModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        ZStack {
            NavigationLink(destination: favoriteRouter.makeDetailView(for: movie)) {
                content()
            }
        }
    }
}
