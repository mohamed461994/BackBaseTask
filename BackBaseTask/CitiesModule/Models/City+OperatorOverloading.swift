//
//  City+OperatorOverloading.swift
//  BackBaseTask
//
//  Created by Muhamed Shaban on 05/06/2021.
//

import Foundation

func ==(lhs: City, rhs: String) -> Bool {
    return lhs.name.lowercased().hasPrefix(rhs.lowercased())
}

func <(lhs: City, rhs: String) -> Bool {
    return lhs.name.lowercased() < rhs.lowercased()
}

func >(lhs: City, rhs: String) -> Bool {
    return lhs.name.lowercased() > rhs.lowercased()
}
