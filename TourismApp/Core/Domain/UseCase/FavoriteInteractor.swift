//
//  FavoriteInteractor.swift
//  TourismApp
//
//  Created by Aria Pratomo on 17/02/22.
//

import Foundation
import RxSwift

protocol FavoriteUseCase {

  func getTourismListLocale() -> Observable<[TourismModel]>

}

class FavoriteInteractor: FavoriteUseCase {
    
    private let repository: TourismRepositoryProtocol
    
    required init(repository: TourismRepositoryProtocol) {
      self.repository = repository
    }
    
    func getTourismListLocale() -> Observable<[TourismModel]>{
        return repository.getTourismListLocale()
    }

}
