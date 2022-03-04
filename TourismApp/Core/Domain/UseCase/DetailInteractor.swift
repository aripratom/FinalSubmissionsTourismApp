//
//  DetailInteractor.swift
//  TourismApp
//
//  Created by Aria Pratomo on 16/02/22.
//

import Foundation
import RxSwift

protocol DetailUseCase {

    func getTourism() -> TourismModel
    func getTourismLocale() -> Observable<[TourismModel]>
    func saveTourism(tourism: TourismModel) -> Observable<Bool>
    func deleteTourism(tourism: TourismModel) -> Observable<Bool>
}

class DetailInteractor: DetailUseCase {

  private let repository: TourismRepositoryProtocol
  private let tourism: TourismModel

  required init(
    repository: TourismRepositoryProtocol,
    tourism: TourismModel
  ) {
    self.repository = repository
    self.tourism = tourism
  }

  func getTourism() -> TourismModel {
    return tourism
  }
    
  func saveTourism(tourism: TourismModel) -> Observable<Bool> {
    return repository.addTourism(tourism: tourism)
  }
    
   func deleteTourism(tourism: TourismModel) -> Observable<Bool> {
    return repository.deleteTourism(tourism: tourism)
   }
    
    func getTourismLocale() -> Observable<[TourismModel]> {
        return repository.getTourismListLocale()
    }
    

}
