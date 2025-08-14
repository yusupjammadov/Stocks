//
//  StockItemModel.swift
//  LuxuryTask
//
//  Created by Yusup Jammadov on 29.07.2025.
//

import Foundation

struct StockItemModel: Codable {
    let symbol: String
    let name: String
    let price: Float
    let change: Float
    let changePercent: Float
    let logo: String
}
