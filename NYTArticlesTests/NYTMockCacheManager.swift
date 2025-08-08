//
//  NYTMockCacheManager.swift
//  NYTArticles
//
//  Created by Jeslin Johnson on 08/08/2025.
//

@testable import NYTArticles

final class NYTMockCacheManager: NYTCacheManagerProtocol {
    var savedArticles: [NYTArticleModel] = []
    var articlesToLoad: [NYTArticleModel]? = nil

    func saveArticles(_ articles: [NYTArticleModel]) {
        savedArticles = articles
    }

    func loadCachedArticles() -> [NYTArticleModel]? {
        return articlesToLoad
    }
}
