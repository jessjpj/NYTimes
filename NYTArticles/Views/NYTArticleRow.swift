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
        HStack(alignment: .top, spacing: NYTConstants.Layout.detailImageCornerRadius) {
            WebImage(url: imageUrl, options: [.delayPlaceholder])
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: NYTConstants.Layout.imageSize, height: NYTConstants.Layout.imageSize)
                .clipped()
                .cornerRadius(NYTConstants.Layout.cornerRadius)
                .overlay {
                    if imageUrl == nil {
                        Image(systemName: NYTConstants.ImageNames.photoPlaceholderIconName)
                            .resizable()
                            .scaledToFit()
                            .padding(NYTConstants.Layout.imagePadding)
                            .frame(width: NYTConstants.Layout.imageSize, height: NYTConstants.Layout.imageSize)
                            .foregroundColor(NYTConstants.Colors.placeholderIconColor)
                            .progressViewStyle(.circular)
                    }
                }

            VStack(alignment: .leading, spacing: 6) {
                Text(article.title ?? "")
                    .font(NYTFonts.headline)
                    .lineLimit(NYTConstants.LineLimit.limit2)

                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(article.byline ?? "")
                            .font(NYTFonts.subheadline)
                            .lineLimit(NYTConstants.LineLimit.limit2)

                        if let byline = article.byline, byline.count < 30 {
                            HStack {
                                Spacer()
                            }
                        }
                    }

                    Spacer()

                    HStack(spacing: 4) {
                        Image(systemName: NYTConstants.ImageNames.calendarIconName)
                            .font(NYTFonts.caption)
                        Text(article.published_date ?? "")
                            .font(NYTFonts.caption)
                    }
                }

            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, NYTConstants.Layout.cornerRadius)
    }
}
