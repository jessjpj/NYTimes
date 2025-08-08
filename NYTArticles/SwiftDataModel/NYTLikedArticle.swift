//
//  NYTLikedArticle.swift
//  NYTArticles
//
//  Created by Jeslin Johnson on 08/08/2025.
//

import SwiftData
import Foundation

@Model
class NYTLikedArticle: Identifiable {
    @Attribute(.unique) var id: String
    var url: String?
    var title: String?
    var abstract: String?
    var byline: String?
    var published_date: String?
    var mediaDataJSON: Data?

    var media: [NYTMedia]? {
        get {
            guard let mediaDataJSON = mediaDataJSON else { return nil }
            do {
                return try JSONDecoder().decode([NYTMedia].self, from: mediaDataJSON)
            } catch {
                print("Failed to decode media data: \(error)")
                return nil
            }
        }
        set {
            guard let newValue = newValue else {
                mediaDataJSON = nil
                return
            }
            do {
                mediaDataJSON = try JSONEncoder().encode(newValue)
            } catch {
                print("Failed to encode media data: \(error)")
                mediaDataJSON = nil
            }
        }
    }

    init(article: NYTArticleModel) {
        self.id = article.id
        self.url = article.url
        self.title = article.title
        self.abstract = article.abstract
        self.byline = article.byline
        self.published_date = article.published_date

        if let media = article.media {
            do {
                self.mediaDataJSON = try JSONEncoder().encode(media)
            } catch {
                print("Failed to encode media data: \(error)")
                self.mediaDataJSON = nil
            }
        } else {
            self.mediaDataJSON = nil
        }
    }
}
