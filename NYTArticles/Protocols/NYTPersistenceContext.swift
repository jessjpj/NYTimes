//
//  NYTPersistenceContext.swift
//  NYTArticles
//
//  Created by Jeslin Johnson on 08/08/2025.
//


protocol NYTPersistenceContext {
    func fetchLikedArticles() throws -> [NYTLikedArticle]
    func insert(_ article: NYTLikedArticle)
    func delete(_ article: NYTLikedArticle)
}
