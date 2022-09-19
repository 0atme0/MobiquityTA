//
//  Constants.swift
//  MobiquityTA
//
//  Created by atme on 19/09/2022.
//

import Foundation

struct Constants {
    struct Network {
        static let WEBSERVICE_BASE_URL = "https://api.flickr.com/services/rest"
        static let API_KEY = "44761f64191a244f94126acb50e1c22d"
        static let API_SECRET = "535fde873ec37d61"
        static let SEARCH_BY_KEYWORD = "flickr.photos.search"
    }
}

extension Constants {
    struct Storage {
        static let K_SEARCH_HISTORY = "kSearchHistory"
    }
}
