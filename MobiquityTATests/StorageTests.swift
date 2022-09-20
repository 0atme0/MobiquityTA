//
//  StorageTests.swift
//  MobiquityTATests
//
//  Created by atme on 20/09/2022.
//

import XCTest
@testable import MobiquityTA

final class StorageTests: XCTestCase {

    var storage: any StorageProtocol = Storage()
    
    func testCorrectValueToSave() throws {
        let searchValue = "test value"
        storage.saveSearchText(searchValue)
        XCTAssertTrue(storage.searchHistory.contains(searchValue))
    }
    func testIncorrectValueToSave() throws {
        let searchValue = "test value1"
        let incorrectSearchValue = "test value2"
        storage.saveSearchText(searchValue)
        XCTAssertFalse(storage.searchHistory.contains(incorrectSearchValue))
    }
    func testEmptyValueToSave() throws {
        let currentStorageCount = storage.searchHistory.count
        let searchValue = ""
        storage.saveSearchText(searchValue)
        XCTAssertEqual(currentStorageCount, storage.searchHistory.count)
    }

}
