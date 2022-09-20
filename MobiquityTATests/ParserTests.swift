//
//  ParserTests.swift
//  MobiquityTATests
//
//  Created by atme on 20/09/2022.
//

import XCTest
@testable import MobiquityTA

final class ParserTests: XCTestCase {

    let parser: ParserProtocol = Parser()

    func testParseEmptyData() throws {
        let data = Data()
        let result = parser.photoSearch(json: data)
        switch result {
        case .success(let photos):
            XCTFail("The return value shouldn't be successful")
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, "The data couldn’t be read because it isn’t in the correct format.")
        }
    }
    func testParseRealData() throws {
        let testBundle = Bundle(for: type(of: self))
        let url = testBundle.url(forResource: "SearchResponse", withExtension: "json")
        let data = try? Data(contentsOf: url!)
        let result = parser.photoSearch(json: data!)
        switch result {
        case .success(let photos):
            XCTAssertTrue(photos.count > 0)
        case .failure(let error):
            XCTFail("The result shouldn't be failure")
        }
    }
    
    func testParseWrongData() throws {
        let testBundle = Bundle(for: type(of: self))
        let url = testBundle.url(forResource: "SearchWrongResponse", withExtension: "json")
        let data = try? Data(contentsOf: url!)
        let result = parser.photoSearch(json: data!)
        switch result {
        case .success(let photos):
            XCTFail("The return value shouldn't be successful")
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, "The data couldn’t be read because it is missing.")
        }
    }

}
