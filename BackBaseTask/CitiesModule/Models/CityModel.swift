//
//  CityModel.swift
//  BackBaseTask
//
//  Created by Muhamed Shaban on 03/06/2021.
//

import Foundation

// MARK: - City
struct City: Codable, Comparable {
    
    let country, name: String
    let id: Int
    let coord: Coord

    enum CodingKeys: String, CodingKey {
        case country, name
        case id = "_id"
        case coord
    }
    
    static func < (lhs: City, rhs: City) -> Bool {
        return lhs.name.lowercased() < rhs.name.lowercased()
    }
    
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.name.lowercased() == rhs.name.lowercased()
    }
}

// MARK: - Coordinates
struct Coord: Codable {
    let lon, lat: Double
}
