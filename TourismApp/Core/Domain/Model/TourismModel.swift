//
//  TourismModel.swift
//  TourismApp
//
//  Created by Aria Pratomo on 16/02/22.
//

import Foundation

struct TourismModel: Equatable, Identifiable {

    let id: Int
    let name: String
    let image: String
    let description: String
    let address: String
    let like: Int
  
}
