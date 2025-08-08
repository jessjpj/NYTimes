//
//  NYTAPIConfiguration.swift
//  NYTArticles
//
//  Created by Jeslin Johnson on 08/08/2025.
//

import Foundation

final class NYTAPIConfiguration {
    static let shared = NYTAPIConfiguration()
    private let keychainKey = Bundle.main.bundleIdentifier! + ".NYTAPIKey"

    private let testAPIKey = "use the key from mail"

    private init() {
        if NYTKeychainHelper.shared.read(key: keychainKey) == nil {
            NYTKeychainHelper.shared.save(value: testAPIKey, key: keychainKey)
        }
    }

    func getAPIKey() -> String? {
        return NYTKeychainHelper.shared.read(key: keychainKey)
    }

    func getBaseURLString() -> String {
        return "https://api.nytimes.com/svc/mostpopular/v2/viewed"
    }
}
