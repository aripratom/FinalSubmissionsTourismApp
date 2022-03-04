//
//  Injection.swift
//  TourismApp
//
//  Created by Aria Pratomo on 16/02/22.
//

import Foundation
import RealmSwift
import Core
import Tourism
import UIKit

final class Injection: NSObject {
  
  private func provideRepository() -> TourismRepositoryProtocol {

    let realm = try? Realm()
    let remote: RemoteDataSource = RemoteDataSource.sharedInstance
    let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)

    return TourismRepository.sharedInstance(remote, locale)
  }

  func provideHome() -> HomeUseCase {
    let repository = provideRepository()
    return HomeInteractor(repository: repository)
  }
    func provideFavorite() -> FavoriteUseCase {
      let repository = provideRepository()
      return FavoriteInteractor(repository: repository)
    }

  func provideDetail(tourism: TourismModel) -> DetailUseCase {
    let repository = provideRepository()
    return DetailInteractor(repository: repository, tourism: tourism)
  }
    
    
    
    

}
