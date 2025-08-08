//
//  NYTArticleRow.swift
//  NYTArticles
//
//  Created by Jeslin Johnson on 08/08/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct NYTArticleRow: View {
    let article: NYTArticleModel

    var imageUrl: URL? {
        URL(string: article.media?.first?.mediaMetadata?.last?.url ?? "")
    }

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            WebImage(url: imageUrl, options: [.delayPlaceholder])
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipped()
                .cornerRadius(8)
                .overlay {
                    if imageUrl == nil {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .padding(20)
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray.opacity(0.5))
                            .progressViewStyle(.circular)
                    }
                }

            VStack(alignment: .leading, spacing: 6) {
                Text(article.title ?? "")
                    .font(.headline)
                    .lineLimit(2)

                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(article.byline ?? "")
                            .font(.subheadline)
                            .lineLimit(2)

                        if let byline = article.byline, byline.count < 30 {
                            HStack {
                                Spacer()
                            }
                        }
                    }

                    Spacer()

                    HStack(spacing: 4) {
                        Image(systemName: "calendar")
                            .font(.caption)
                        Text(article.published_date ?? "")
                            .font(.caption)
                    }
                }

            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .frame(alignment: .center)
        }
        .padding(.vertical, 8)
    }
}
