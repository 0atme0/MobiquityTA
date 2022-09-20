//
//  MockNetwork.swift
//  MobiquityTATests
//
//  Created by atme on 20/09/2022.
//

import Foundation
@testable import MobiquityTA

class MockNetwork: NetworkProtocol {
    func sendRequest(_ url: String, parameters: [String : String], completion: @escaping MobiquityTA.NetworkResultHandler) {
        let testBundle = Bundle(for: type(of: self))
        let url = testBundle.url(forResource: "SearchResponse", withExtension: "json")
        let data = try? Data(contentsOf: url!)

        completion(.success(data!))
    }
    
}

class MockNetworkWithEmptyData: NetworkProtocol {
    func sendRequest(_ url: String, parameters: [String : String], completion: @escaping MobiquityTA.NetworkResultHandler) {
        completion(.success(Data()))
    }
    
}
