//
//  HomePresenter.swift
//  TourismApp
//
//  Created by Aria Pratomo on 16/02/22.
//

import Foundation
import SwiftUI
import RxSwift

class HomePresenter: ObservableObject {

    @State private var tabBar: UITabBar! = nil
  //private let router = HomeRouter()
  private let homeUseCase: HomeUseCase
    private let disposeBag = DisposeBag()

  @Published var tourismList: [TourismModel] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  
  init(homeUseCase: HomeUseCase) {
    self.homeUseCase = homeUseCase
  }
  
  func getTourismList() {
    loadingState = true
    homeUseCase.getTourismList().observe(on: MainScheduler.instance)
        .subscribe{ result in
            self.tourismList = result
            self.loadingState = false
        } onError: { error in
            self.errorMessage = error.localizedDescription
        } onCompleted: {
            self.loadingState = false
        }.disposed(by: disposeBag)
  }
  
//  func linkBuilder<Content: View>(
//    for tourism: TourismModel,
//    @ViewBuilder content: () -> Content
//  ) -> some View {
//    NavigationLink(
//        destination: homeRouter.makeDetailView(for: tourism)) { content() }
//  }

}
