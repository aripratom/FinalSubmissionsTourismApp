//
//  HomeInteractor.swift
//  TourismApp
//
//  Created by Aria Pratomo on 16/02/22.
//

import Foundation
import RxSwift

protocol HomeUseCase {

  func getTourismList() -> Observable<[TourismModel]>

}

class HomeInteractor: HomeUseCase {
    
    private let repository: TourismRepositoryProtocol
    
    required init(repository: TourismRepositoryProtocol) {
      self.repository = repository
    }
    
    func getTourismList() -> Observable<[TourismModel]>{
        return repository.getTourismList()
    }

}
