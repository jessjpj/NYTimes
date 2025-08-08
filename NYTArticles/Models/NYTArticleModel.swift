//
//  NYTArticleModel.swift
//  NYTArticles
//
//  Created by Jeslin Johnson on 08/08/2025.
//

import Foundation

struct NYTArticleModel: Codable, Identifiable, Equatable {
    var id: String { url ?? UUID().uuidString }
    let url: String?
    let title: String?
    let abstract: String?
    let byline: String?
    let published_date: String?
    let media: [NYTMedia]?
}

struct NYTMedia: Codable, Equatable {
    let mediaMetadata: [NYTMediaMetadata]?

    enum CodingKeys: String, CodingKey {
        case mediaMetadata = "media-metadata"
    }
}

struct NYTMediaMetadata: Codable, Equatable {
    let url: String?
    let format: String?
}

extension NYTArticleModel {
    init(from likedArticle: NYTLikedArticle) {
        self.init(
            url: likedArticle.url,
            title: likedArticle.title,
            abstract: likedArticle.abstract,
            byline: likedArticle.byline,
            published_date: likedArticle.published_date,
            media: likedArticle.mediaData
        )
    }
}
