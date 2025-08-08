//
//  NYTLikedViewModel.swift
//  NYTArticles
//
//  Created by Jeslin Johnson on 08/08/2025.
//


import SwiftUI
import SwiftData

final class NYTLikedViewModel: ObservableObject {
    @Published var articles: [NYTArticleModel] = []

    private let persistenceContext: NYTPersistenceContext

    init(persistenceContext: NYTPersistenceContext) {
        self.persistenceContext = persistenceContext
        loadLikedArticles()
    }

    func loadLikedArticles() {
        do {
            let likedArticles = try persistenceContext.fetchLikedArticles()
            self.articles = likedArticles.map { NYTArticleModel(from: $0) }
        } catch {
            print("Failed to fetch liked articles:", error)
            self.articles = []
        }
    }
}
