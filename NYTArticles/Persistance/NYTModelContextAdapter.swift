//
//  NYTModelContextAdapter.swift
//  NYTArticles
//
//  Created by Jeslin Johnson on 08/08/2025.
//


import SwiftData
import Foundation

class NYTModelContextAdapter: NYTPersistenceContext {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func fetchLikedArticles() throws -> [NYTLikedArticle] {
        let fetchDescriptor = FetchDescriptor<NYTLikedArticle>(sortBy: [SortDescriptor(\.title)])
        return try context.fetch(fetchDescriptor)
    }

    func insert(_ article: NYTLikedArticle) {
        context.insert(article)
    }

    func delete(_ article: NYTLikedArticle) {
        context.delete(article)
    }
}
