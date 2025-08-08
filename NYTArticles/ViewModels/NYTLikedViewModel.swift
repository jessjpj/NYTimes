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
    @Published var selectedArticle: NYTArticleModel?

    private var modelContext: ModelContext

    init(context: ModelContext) {
        self.modelContext = context
        loadLikedArticles()
    }

    func loadLikedArticles() {
        do {
            let fetchDescriptor = FetchDescriptor<NYTLikedArticle>(sortBy: [SortDescriptor(\.title)])
            let likedArticles = try modelContext.fetch(fetchDescriptor)
            self.articles = likedArticles.map { NYTArticleModel(from: $0) }
        } catch {
            print("Failed to fetch liked articles:", error)
            self.articles = []
        }
    }
}
