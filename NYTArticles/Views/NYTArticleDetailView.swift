//
//  NYTArticleDetailView.swift
//  NYTArticles
//
//  Created by Jeslin Johnson on 08/08/2025.
//

import SwiftUI
import SwiftData
import SDWebImageSwiftUI

struct NYTArticleDetailView: View {
    let article: NYTArticleModel

    @Environment(\.modelContext) private var context
    @Query private var likedArticles: [NYTLikedArticle]

    @State private var isLiked: Bool = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: NYTConstants.Layout.contentSpacing) {
                if let url = URL(string: article.media?.first?.mediaMetadata?.last?.url ?? "") {
                    WebImage(url: url)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(NYTConstants.Layout.detailImageCornerRadius)
                }
                Text(article.title ?? "")
                    .font(NYTFonts.title)

                Text(article.byline ?? "")
                    .font(NYTFonts.subheadline)

                Text(article.abstract ?? "")
                    .font(NYTFonts.body)

                Button(action: toggleLike) {
                    Label(isLiked ? NYTConstants.Strings.unlike : NYTConstants.Strings.like, systemImage: isLiked ? NYTConstants.ImageNames.likedIconName : NYTConstants.ImageNames.likeIconName)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(NYTConstants.Colors.likeButtonBackground)
                        .cornerRadius(NYTConstants.Layout.buttonCornerRadius)
                }
            }
            .padding()
        }
        .navigationTitle(NYTConstants.Strings.detailsTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if let urlString = article.url, let url = URL(string: urlString) {
                    ShareLink(item: url) {
                        Image(systemName: NYTConstants.ImageNames.shareIconName)
                    }
                }
            }
        }
        .onAppear {
            isLiked = likedArticles.contains { $0.id == article.id }
        }
    }

    private func toggleLike() {
        if let existing = likedArticles.first(where: { $0.id == article.id }) {
            context.delete(existing)
            isLiked = false
        } else {
            let liked = NYTLikedArticle(article: article)
            context.insert(liked)
            isLiked = true
        }
    }
}

