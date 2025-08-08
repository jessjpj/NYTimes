//
//  NYTCacheManager.swift
//  NYTArticles
//
//  Created by Jeslin Johnson on 08/08/2025.
//

import Foundation


final class NYTCacheManager: NYTCacheManagerProtocol {
    static let shared = NYTCacheManager()
    private init() {}

    private let cacheKey = "cachedArticles"

    func saveArticles(_ articles: [NYTArticleModel]) {
        do {
            let data = try JSONEncoder().encode(articles)
            UserDefaults.standard.set(data, forKey: cacheKey)
        } catch {
            print("Failed to save articles to cache: \(error)")
        }
    }

    func loadCachedArticles() -> [NYTArticleModel]? {
        guard let data = UserDefaults.standard.data(forKey: cacheKey) else { return nil }
        return try? JSONDecoder().decode([NYTArticleModel].self, from: data)
    }
}
