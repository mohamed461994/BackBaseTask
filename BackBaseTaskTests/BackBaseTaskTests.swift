//
//  BackBaseTaskTests.swift
//  BackBaseTaskTests
//
//  Created by Muhamed Shaban on 03/06/2021.
//

import XCTest
@testable import BackBaseTask

class BackBaseTaskTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// This Test Search for single item in a list that is not sorted
    func testBinarrySearchResultValue() throws {
        let interactor = CitiesInteractor()
        let sampleData = City.getUnSortedSampleData1()
        let CitiesModels = interactor.mapCitiesJsonData(from: sampleData)
        let holubynkaCityModel = CitiesModels[1]
        let sortedCitiesModels = CitiesModels.sorted { $0 < $1 }
        let searchResult = interactor.binarySearch(in: sortedCitiesModels, for: "h")
        XCTAssertEqual(holubynkaCityModel, searchResult[0])
    }
    
    /// This Test Search for with "A" char which should have 4 results
    func testBinarrySearchResultsCount() {
        let interactor = CitiesInteractor()
        let sampleData = City.getUnSortedSampleData1()
        let sortedCitiesModels = interactor.mapCitiesJsonData(from: sampleData).sorted { $0 < $1 }
        let searchResult = interactor.binarySearch(in: sortedCitiesModels, for: "a")
        XCTAssertEqual(searchResult.count, 4, "Search Results should be 4 ")
    }
    
    /// This Test that Search is case insensitive
    func testBinarrySearchCaseInsensitive() {
        let interactor = CitiesInteractor()
        let sampleData = City.getUnSortedSampleData2()
        let sortedCitiesModels = interactor.mapCitiesJsonData(from: sampleData).sorted { $0 < $1 }
        let searchResultOfB = interactor.binarySearch(in: sortedCitiesModels, for: "B")
        let searchResultOfb = interactor.binarySearch(in: sortedCitiesModels, for: "b")
        XCTAssertEqual(searchResultOfB.count, searchResultOfb.count, "Search Results for both b and B should be same")
    }
    
    func testBinarrySearchResultsAreAlphabeticallySorted() {
        let interactor = CitiesInteractor()
        let sampleData = City.getUnSortedSampleData2()
        let sortedCitiesModels = interactor.mapCitiesJsonData(from: sampleData).sorted { $0 < $1 }
        let searchResult = interactor.binarySearch(in: sortedCitiesModels, for: "a")
        XCTAssertEqual(searchResult[0].name, "aav", "1st City should be aav")
        XCTAssertEqual(searchResult[1].name, "Abc", "2nd City should be Abc")
        XCTAssertEqual(searchResult[2].name, "Ajd", "3rd City should be Ajd")
    }
    
    func testInvalidSearchInput() {
        let interactor = CitiesInteractor()
        let sampleData = City.getUnSortedSampleData1()
        let sortedCitiesModels = interactor.mapCitiesJsonData(from: sampleData).sorted { $0 < $1 }
        let searchResult = interactor.binarySearch(in: sortedCitiesModels, for: "Yb")
        XCTAssertEqual(searchResult.count, 0, "Search results for prefix Yb should be zero")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
