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
    
    /// This Will be user while sorting Cities
    static func < (lhs: City, rhs: City) -> Bool {
        return "\(lhs.name) \(lhs.country)".lowercased() < "\(rhs.name) \(lhs.country)".lowercased()
    }
    
    /// This will be used in unit testing
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.name.lowercased() == rhs.name.lowercased()
    }
}

// MARK: - Coordinates
struct Coord: Codable {
    let lon, lat: Double
}

extension City {
    
    /// This is a testing json data
    /// - Returns: Data of Cities Json
    static func getUnSortedSampleData1() -> Data {
       return """
        [
        {"country":"US","name":"Alabama","_id":707860,"coord":{"lon":34.283333,"lat":44.549999}},
        {"country":"AU","name":"Holubynka","_id":708546,"coord":{"lon":33.900002,"lat":44.599998}},
        {"country":"US","name":"Albuquerque","_id":519188,"coord":{"lon":37.666668,"lat":55.683334}},
        {"country":"US","name":"Anaheim","_id":1283378,"coord":{"lon":84.633331,"lat":28}},
        {"country":"US","name":"Arizona","_id":1270260,"coord":{"lon":76,"lat":29}}
        ]
        """.data(using: .utf8)!
    }
    
    /// This is a testing json data
    /// - Returns: Data of Cities Json
    static func getUnSortedSampleData2() -> Data {
       return """
        [
        {"country":"US","name":"Abc","_id":707860,"coord":{"lon":34.283333,"lat":44.549999}},
        {"country":"US","name":"Ajd","_id":708546,"coord":{"lon":33.900002,"lat":44.599998}},
        {"country":"US","name":"BAa","_id":519188,"coord":{"lon":37.666668,"lat":55.683334}},
        {"country":"US","name":"bBa","_id":1283378,"coord":{"lon":84.633331,"lat":28}},
        {"country":"US","name":"aav","_id":1270260,"coord":{"lon":76,"lat":29}}
        ]
        """.data(using: .utf8)!
    }
}
