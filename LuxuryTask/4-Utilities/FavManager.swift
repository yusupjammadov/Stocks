//
//  FavManager.swift
//  LuxuryTask
//
//  Created by Yusup Jammadov on 30.07.2025.
//

import Foundation
import RxRelay

class FavManager {
    
    private init() {}
    
    static let favRelay = PublishRelay<(String,Bool)>()
    
    static func get(isFav ticker: String) -> Bool {
        return UserDefaults.standard.bool(forKey: ticker)
    }
    static func set(_ ticker: String, isFav: Bool) {
        UserDefaults.standard.set(isFav, forKey: ticker)
        favRelay.accept((ticker,isFav))
    }
}
