//
//  FavoriteRouter.swift
//  TourismApp
//
//  Created by Aria Pratomo on 04/03/22.
//

import Cleanse
import SwiftUI
import Core
import Tourism

class FavoriteRouter {
    let detailPresenter: Factory<TourismDetailPresenter.AssistedFeed>
    let updatePresenter: TourismUpdatePresenter
    
    init(detailPresenter: Factory<TourismDetailPresenter.AssistedFeed>, updateFavoritePresenter: TourismUpdatePresenter
    ) {
        self.detailPresenter = detailPresenter
        self.updatePresenter = updateFavoritePresenter
    }
    
    func makeDetailView(for tourism: TourismDomainModel) -> some View {
        return TourismDetailView(presenter: detailPresenter.build(tourism), updatePresenter: updatePresenter
        )
    }
}

extension FavoriteRouter {
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.include(module: TourismDetailPresenter.Module.self)
            binder.bind(FavoriteRouter.self).to(factory: FavoriteRouter.init)
        }
    }
}
