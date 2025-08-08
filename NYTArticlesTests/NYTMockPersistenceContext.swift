//
//  NYTMockPersistenceContext.swift
//  NYTArticles
//
//  Created by Jeslin Johnson on 08/08/2025.
//

@testable import NYTArticles
import Foundation

class NYTMockPersistenceContext: NYTPersistenceContext {
    var likedArticlesToReturn: [NYTLikedArticle] = []
    var insertedArticles: [NYTLikedArticle] = []
    var deletedArticles: [NYTLikedArticle] = []
    var shouldThrowOnFetch = false

    func fetchLikedArticles() throws -> [NYTLikedArticle] {
        if shouldThrowOnFetch {
            throw NSError(domain: "TestError", code: 1)
        }
        return likedArticlesToReturn
    }

    func insert(_ article: NYTLikedArticle) {
        insertedArticles.append(article)
    }

    func delete(_ article: NYTLikedArticle) {
        deletedArticles.append(article)
    }
}
