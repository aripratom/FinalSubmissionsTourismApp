//
//  TourismDetailPresenter.swift
//  TourismApp
//
//  Created by Aria Pratomo on 16/02/22.
//

import Foundation
import SwiftUI
import RxSwift
import AlertToast

class TourismssDetailPresenter: ObservableObject {
    
    private let detailUseCase: DetailUseCase
    private let disposeBag = DisposeBag()
    //private let router = HomeRouter()
    
    @Published var tourism: TourismModel
    @Published var listTourismLocal: [TourismModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    @Published var results: Bool = false
    @Published var checkFavorite: Bool = false
    @Published var show = false
        @Published var alertToast = AlertToast(type: .regular, title: "SOME TITLE"){
            didSet{
                show.toggle()
            }
        }
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
        tourism = detailUseCase.getTourism()
    }
    
    func saveTourism(tourism: TourismModel) {
        loadingState = true
        detailUseCase.saveTourism(tourism: tourism).observe(on: MainScheduler.instance)
            .subscribe { result in
                self.results = result
                print(self.results)
                self.loadingState = false
                self.show = true
                self.checkFav()
            } onError: { error in
                print("ERROR DARI SAVE" + error.localizedDescription)
                self.errorMessage = error.localizedDescription
            } onCompleted: {
                self.loadingState = false
                self.results = true
            }.disposed(by: disposeBag)
        
    }
    
    func deleteTourism(tourism: TourismModel) {
        loadingState = true
        detailUseCase.deleteTourism(tourism: tourism).observe(on: MainScheduler.instance)
            .subscribe { result in
                self.results = result
                print(self.results)
                self.show = true
                self.loadingState = false
                self.checkFav()
            } onError: { error in
                print("ERROR DARI DELETE" + error.localizedDescription)
                self.errorMessage = error.localizedDescription
            } onCompleted: {
                self.loadingState = false
                self.results = true
            }.disposed(by: disposeBag)
        
    }
    
    func getTourismListFavorite() {
        loadingState = true
        detailUseCase.getTourismLocale().observe(on: MainScheduler.instance)
            .subscribe{ result in
                self.listTourismLocal = result
                self.loadingState = false
                self.checkFav()
            } onError: { error in
                self.errorMessage = error.localizedDescription
            } onCompleted: {
                self.loadingState = false
            }.disposed(by: disposeBag)
    }
    
    func checkFav() {
        for list in self.listTourismLocal {
            if list.id == self.tourism.id {
                self.checkFavorite = true
                print("TRUE CHECK FAV")
                break
            } else {
                self.checkFavorite = false
                print("FALSE CHECK FAV")
            }
        }
    }
    
    func getStatus() -> Bool {
        return self.results
    }
    
//    func linkBuilder<Content: View>(
//        for tourism: TourismModel,
//        @ViewBuilder content: () -> Content
//    ) -> some View {
//        NavigationLink(
//            destination: router.goHome()) { content()
//            }
//    }
}
