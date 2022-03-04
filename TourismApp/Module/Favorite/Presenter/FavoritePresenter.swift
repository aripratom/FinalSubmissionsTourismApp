//
//  FavoritePresenter.swift
//  TourismApp
//
//  Created by Aria Pratomo on 17/02/22.
//

import Foundation
import SwiftUI
import RxSwift
import AlertToast

class FavoritePresenter: ObservableObject {
    
    //private let router = HomeRouter()
    private let favoriteUseCase: FavoriteUseCase
    private let disposeBag = DisposeBag()
    
    @Published var tourismList: [TourismModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(favoriteUseCase: FavoriteUseCase) {
        self.favoriteUseCase = favoriteUseCase
    }
    
    func getTourismListFavorite() {
        tourismList.shuffle()
        loadingState = true
        favoriteUseCase.getTourismListLocale().observe(on: MainScheduler.instance)
            .subscribe{ result in
                self.tourismList = result
                self.loadingState = false
            } onError: { error in
                self.errorMessage = error.localizedDescription
            } onCompleted: {
                self.loadingState = false
            }.disposed(by: disposeBag)
    }
    
//    func linkBuilder<Content: View>(
//        for tourism: TourismModel,
//        @ViewBuilder content: () -> Content
//    ) -> some View {
//        NavigationLink(
//            destination: router.makeDetailView(for: tourism)) { content() }
//    }
    
}
