//
//  NYTArticleDetailView.swift
//  NYTArticles
//
//  Created by Jeslin Johnson on 08/08/2025.
//

import SwiftUI
import SDWebImageSwiftUI
import SwiftData

struct NYTArticleDetailView: View {
    let article: NYTArticleModel?
    @Environment(\ .modelContext) private var context
    @Query private var likedArticles: [NYTLikedArticle]

    var isLiked: Bool {
        likedArticles.contains(where: { $0.id == article?.id })
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let url = URL(string: article?.media?.first?.mediaMetadata?.last?.url ?? "") {
                WebImage(url: url)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(12)
            }

            Text(article?.title ?? "")
                .font(.title2)
                .bold()

            Text(article?.byline ?? "")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Text(article?.abstract ?? "")
                .font(.body)

            Spacer()

            Button(action: toggleLike) {
                Label(isLiked ? "Unlike" : "Like", systemImage: isLiked ? "heart.fill" : "heart")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if let urlString = article?.url, let url = URL(string: urlString) {
                    ShareLink(item: url) {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
        }
    }

    private func toggleLike() {
        guard let article = article else { return }

        if let existing = likedArticles.first(where: { $0.id == article.id }) {
            context.delete(existing)
        } else {
            let liked = NYTLikedArticle(article: article)
            context.insert(liked)
        }
    }
}
