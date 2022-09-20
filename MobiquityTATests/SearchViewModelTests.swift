//
//  SearchViewModelTests.swift
//  MobiquityTATests
//
//  Created by atme on 20/09/2022.
//

import XCTest
@testable import MobiquityTA

final class SearchViewModelTests: XCTestCase {

    var vm = SearchViewModel()

    func testInitialisation() throws {
        XCTAssertEqual(vm.photos.count, 0)
        XCTAssertNil(vm.showingError)
        XCTAssertEqual(vm.currentPage, 0)
        XCTAssertEqual(vm.currentSearchText, "")
        XCTAssertEqual(vm.photosListFull, false)
    }
    
    func testSearchFunctionChangesSearchTextAndSearchHistory() throws {
        let mockNetwork = MockNetwork()
        let searchWorker = SearchWorker(network: mockNetwork)
        vm = SearchViewModel(searchWorker: searchWorker)
        let text = "test"
        vm.search(text)
        XCTAssertEqual(vm.currentSearchText, text)
        XCTAssertTrue(vm.storage.searchHistory.contains(text))
    }
    
    func testFetchFunctionChangesCurrentPageValue() throws {
        let mockNetwork = MockNetwork()
        let searchWorker = SearchWorker(network: mockNetwork)
        vm = SearchViewModel(searchWorker: searchWorker)
        let text = "test"
        vm.fetchNewPage()
        XCTAssertEqual(vm.currentPage, 1)
    }

}
