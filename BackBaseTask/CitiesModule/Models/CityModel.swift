//
//  CityModel.swift
//  BackBaseTask
//
//  Created by Muhamed Shaban on 03/06/2021.
//

import Foundation

// MARK: - City
struct City: Codable {
    let country, name: String
    let id: Int
    let coord: Coord

    enum CodingKeys: String, CodingKey {
        case country, name
        case id = "_id"
        case coord
    }
}

// MARK: - Coordinates
struct Coord: Codable {
    let lon, lat: Double
}

func ==(lhs: City, rhs: String) -> Bool {
    return lhs.name.lowercased().hasPrefix(rhs.lowercased())
}

func <(lhs: City, rhs: String) -> Bool {
    return lhs.name.lowercased() < rhs.lowercased()
}

func >(lhs: City, rhs: String) -> Bool {
    return lhs.name.lowercased() > rhs.lowercased()
}
