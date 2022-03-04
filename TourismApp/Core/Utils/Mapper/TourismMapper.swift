//
//  TourismMapper.swift
//  TourismApp
//
//  Created by Aria Pratomo on 16/02/22.
//

import Foundation

final class TourismMapper {
    
    static func mapTourismDomainToEntities(
      input tourismModel: TourismModel
    ) -> TourismEntity {
      //return tourismModel.map { result in
        let newTourism = TourismEntity()
          newTourism.id = tourismModel.id
          newTourism.name = tourismModel.name
          newTourism.image = tourismModel.image
          newTourism.descriptions = tourismModel.description
          newTourism.address = tourismModel.address
          newTourism.like = tourismModel.like
        return newTourism
      
    }
    
    static func mapTourismEntitiesToDomains(
      input tourismEntities: [TourismEntity]
    ) -> [TourismModel] {
      return tourismEntities.map { result in
        return TourismModel(
            id: result.id,
            name: result.name ,
            image: result.image,
            description: result.descriptions,
            address: result.address,
            like: result.like
        )
      }
    }
    
    static func mapTourismResponsesToDomains(
      input tourismResponses: [TourismResponse]
    ) -> [TourismModel] {

      return tourismResponses.map { result in
        return TourismModel(
          id: result.id ?? 0,
          name: result.name ?? "Unknow",
          image: result.image ?? "Unknow",
          description: result.description ?? "Unknow",
          address: result.address ?? "Unknow",
          like: result.like ?? 0
        )
      }
    }
}
