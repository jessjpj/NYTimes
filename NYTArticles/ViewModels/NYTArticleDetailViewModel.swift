//
//  NYTArticleDetailViewModel.swift
//  NYTArticles
//
//  Created by Jeslin Johnson on 08/08/2025.
//

import Foundation
import SwiftUI

@MainActor
final class NYTArticleDetailViewModel: ObservableObject {
    @Published var isLiked: Bool = false
    @Published var errorMessage: String?
    
    private let article: NYTArticleModel
    private let persistenceContext: NYTPersistenceContext
    
    init(article: NYTArticleModel, persistenceContext: NYTPersistenceContext) {
        self.article = article
        self.persistenceContext = persistenceContext
    }
    
    func checkIfLiked() {
        do {
            let likedArticles = try persistenceContext.fetchLikedArticles()
            isLiked = likedArticles.contains { $0.id == article.id }
        } catch {
            errorMessage = "Failed to check liked status: \(error.localizedDescription)"
            isLiked = false
        }
    }
    
    func toggleLike() {
        do {
            let likedArticles = try persistenceContext.fetchLikedArticles()
            
            if let existing = likedArticles.first(where: { $0.id == article.id }) {
                // Unlike
                persistenceContext.delete(existing)
                isLiked = false
            } else {
                // Like
                let liked = NYTLikedArticle(article: article)
                persistenceContext.insert(liked)
                isLiked = true
            }
        } catch {
            errorMessage = "Failed to toggle like: \(error.localizedDescription)"
        }
    }
    
    // Computed properties for view data
    var imageURL: URL? {
        guard let urlString = article.media?.first?.mediaMetadata?.last?.url else { return nil }
        return URL(string: urlString)
    }
    
    var title: String {
        article.title ?? ""
    }
    
    var byline: String {
        article.byline ?? ""
    }
    
    var abstract: String {
        article.abstract ?? ""
    }
    
    var shareURL: URL? {
        guard let urlString = article.url else { return nil }
        return URL(string: urlString)
    }
    
    var likeButtonText: String {
        isLiked ? NYTConstants.Strings.unlike : NYTConstants.Strings.like
    }
    
    var likeButtonIcon: String {
        isLiked ? NYTConstants.ImageNames.likedIconName : NYTConstants.ImageNames.likeIconName
    }
}
