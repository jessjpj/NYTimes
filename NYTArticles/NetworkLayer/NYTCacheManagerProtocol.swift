//
//  NYTCacheManagerProtocol.swift
//  NYTArticles
//
//  Created by Jeslin Johnson on 08/08/2025.
//


protocol NYTCacheManagerProtocol {
    func saveArticles(_ articles: [NYTArticleModel])
    func loadCachedArticles() -> [NYTArticleModel]?
}
