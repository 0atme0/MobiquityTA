//
//  SearchWorkerTests.swift
//  MobiquityTATests
//
//  Created by atme on 20/09/2022.
//

import XCTest
@testable import MobiquityTA

final class SearchWorkerTests: XCTestCase {
    
    var worker: SearchWorkerProtocol = SearchWorker()
    let mockNetwork = MockNetwork()
    let mockNetworkWithEmptyData = MockNetworkWithEmptyData()
    
    func testCorrectRequest() throws {
        let expectation = self.expectation(description: #function)
        
        worker = SearchWorker(network: mockNetwork)
        worker.searchByKeyword(keyword: "test", perPage: 20, pageNumber: 0) { result in
            switch result {
            case .success(let photos):
                XCTAssertTrue(photos.count > 0)
            case .failure(let error):
                XCTFail("Result shouldn't have errors")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testIncorrectRequest() throws {
        let expectation = self.expectation(description: #function)
        
        worker = SearchWorker(network: mockNetworkWithEmptyData)
        worker.searchByKeyword(keyword: "test", perPage: 20, pageNumber: 0) { result in
            switch result {
            case .success(let photos):
                XCTFail("Result shouldn't be successful")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "The data couldn’t be read because it isn’t in the correct format.")
                
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
