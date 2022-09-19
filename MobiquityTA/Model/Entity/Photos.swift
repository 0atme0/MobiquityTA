//
//  Photos.swift
//  MobiquityTA
//
//  Created by atme on 19/09/2022.
//

import Foundation

// MARK: - Welcome
struct PhotoResponse: Codable {
    let photos: Photos
    let stat: String
}

// MARK: - Photos
struct Photos: Codable {
    let page, pages, perpage, total: Int
    let photo: [Photo]
}

// MARK: - Photo
struct Photo: Codable {
    let id: String
    let owner: String
    let secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
}
