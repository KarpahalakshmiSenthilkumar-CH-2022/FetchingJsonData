//
//  Bakery.swift
//  FetchingJsonData
//
//  Created by Karpahalakshmi on 18/04/24.
//

import Foundation

struct Bakery: Codable {
    let bakery: [BakeryData]
}

struct BakeryData: Codable {
    let id: String?
    let type: String?
    let name: String?
    let ppu: Double?
    let batters: Batters?
    let topping: [Topping]
}

struct Batters: Codable {
    let batter: [Batter]
}

struct Batter: Codable {
    let id: String?
    let type: String?
    let price: String?
    let description: String?
}

struct Topping: Codable {
    let id: String?
    let type: String?
}
