//
//  TourismAppApp.swift
//  TourismApp
//
//  Created by Aria Pratomo on 16/02/22.
//

import SwiftUI
import Core
import Tourism
import Cleanse

@main
class TourismApp: App {

    var homePresenter: TourismListPresenter!
    var favoritePresenter: TourismListFavoritePresenter!
    var router: Router!
    
    
    required init() {
        do {
          let propertyInjector = try ComponentFactory.of(AppComponent.self).build(())
          propertyInjector.injectProperties(into: self)
        } catch {
          print(error)
        }
        
        precondition(homePresenter != nil)
        precondition(favoritePresenter != nil)
        precondition(router != nil)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(router: router, favRouter: router, favoritePresenter: favoritePresenter).environmentObject(homePresenter)
        }
    }
}

extension TourismApp {
    func injectProperties(_ homePresenter: TourismListPresenter,_ favoritePresenter: TourismListFavoritePresenter,_ router: Router) {
        self.homePresenter = homePresenter
        self.favoritePresenter = favoritePresenter
        self.router = router
    }
}
