//
//  CitiesService.swift
//  BackBaseTask
//
//  Created by Muhamed Shaban on 03/06/2021.
//

import Foundation

class CitiesService {
    
    private init () { }
    
    static func shared() -> CitiesService {
        return CitiesService()
    }
 
    func loadCitiesJsonData(_ callBack: @escaping ([City]?) -> Void) {
        if let url = Bundle.main.url(forResource: "cities", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([City].self, from: data)
                print(jsonData.count)
                callBack(jsonData)
            } catch {
                print("error:\(error)")
                return callBack(nil)
            }
        }
        
    }
    
}
