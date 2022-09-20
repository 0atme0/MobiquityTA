//
//  NetworkTests.swift
//  MobiquityTATests
//
//  Created by atme on 20/09/2022.
//

import XCTest
@testable import MobiquityTA

final class NetworkTests: XCTestCase {
    
    let network: NetworkProtocol = Network()
    
    func testCorrectInputs() throws {
        let expectation = self.expectation(description: #function)

        let parameters: [String: String] = [
            "method": Constants.Network.SEARCH_BY_KEYWORD,
            "api_key": Constants.Network.API_KEY,
            "text": "test",
            "per_page": "20",
            "page": "0",
            "format": "json",
            "nojsoncallback": "1"
        ]
        network.sendRequest(Constants.Network.WEBSERVICE_BASE_URL, parameters: parameters) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                XCTFail("Response shouldn't have errors")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testIncorrectURL() throws {
        let expectation = self.expectation(description: #function)
        network.sendRequest("https://test.test", parameters: [:]) { result in
            switch result {
            case .success(let data):
                XCTAssertNil(data)
                XCTFail("Response shouldn't be successful")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "A server with the specified hostname could not be found.")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

}
