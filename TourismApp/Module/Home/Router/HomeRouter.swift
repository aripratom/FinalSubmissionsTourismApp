//
//  HomeRouter.swift
//  TourismApp
//
//  Created by Aria Pratomo on 16/02/22.
//

import Cleanse
import SwiftUI
import Core
import Tourism

class HomeRouter {
    let detailPresenter: Factory<TourismDetailPresenter.AssistedFeed>
    let updatePresenter: TourismUpdatePresenter
    let favoritePresenter: TourismListFavoritePresenter
    
    init(detailPresenter: Factory<TourismDetailPresenter.AssistedFeed>, updateFavoritePresenter: TourismUpdatePresenter, favPresenter: TourismListFavoritePresenter
    ) {
        self.detailPresenter = detailPresenter
        self.updatePresenter = updateFavoritePresenter
        self.favoritePresenter = favPresenter
    }
    
    func makeDetailView(for tourism: TourismDomainModel) -> some View {
        return TourismDetailView(presenter: detailPresenter.build(tourism), updatePresenter: updatePresenter, favoritePresenter: favoritePresenter
        )
    }
}

extension HomeRouter {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: TourismDetailPresenter.Module.self)
            binder.bind(HomeRouter.self).to(factory: HomeRouter.init)
        }
    }
}
