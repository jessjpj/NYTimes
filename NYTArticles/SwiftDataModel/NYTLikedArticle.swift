//
//  NYTLikedArticle.swift
//  NYTArticles
//
//  Created by Jeslin Johnson on 08/08/2025.
//

import SwiftData

@Model
class NYTLikedArticle: Identifiable {
    @Attribute(.unique) var id: String
    var url: String?
    var title: String?
    var abstract: String?
    var byline: String?
    var published_date: String?
    var mediaData: [NYTMedia]?

    init(article: NYTArticleModel) {
        self.id = article.id
        self.url = article.url
        self.title = article.title
        self.abstract = article.abstract
        self.byline = article.byline
        self.published_date = article.published_date
        self.mediaData = article.media
    }
}
