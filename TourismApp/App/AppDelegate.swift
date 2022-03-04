//
//  AppDelegate.swift
//  TourismApp
//
//  Created by Aria Pratomo on 01/03/22.
//

import UIKit
import RealmSwift

class AppDelegate: NSObject, UIApplicationDelegate {
    
   @Published var realm: Realm!
    
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
      
      realm = try! Realm()
    return true
  }
}
