//
//  AppComponent.swift
//  TourismApp
//
//  Created by Aria Pratomo on 03/03/22.
//

import Cleanse
import Tourism
import Core

struct AppComponent: Cleanse.RootComponent {
    
    typealias Root = PropertyInjector<TourismApp>
    static func configure(binder: Binder<Singleton>) {
        binder.include(module: TourismListPresenter.Module.self)
        binder.include(module: Router.Module.self)
    }
    
    static func configureRoot(binder bind: ReceiptBinder<PropertyInjector<TourismApp>>) -> BindingReceipt<PropertyInjector<TourismApp>> {
        return bind.propertyInjector{ (bind) -> BindingReceipt<PropertyInjector<TourismApp>> in
            return bind.to(injector: TourismApp.injectProperties)
        }
    }
    
}
