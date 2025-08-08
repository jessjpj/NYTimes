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
    @StateObject private var viewModel: NYTArticleDetailViewModel
    
    init(article: NYTArticleModel, context: ModelContext) {
        let adapter = NYTModelContextAdapter(context: context)
        _viewModel = StateObject(wrappedValue: NYTArticleDetailViewModel(
            article: article,
            persistenceContext: adapter
        ))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: NYTConstants.Layout.contentSpacing) {
                if let imageURL = viewModel.imageURL {
                    WebImage(url: imageURL)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(NYTConstants.Layout.detailImageCornerRadius)
                }
                
                Text(viewModel.title)
                    .font(NYTFonts.title)

                Text(viewModel.byline)
                    .font(NYTFonts.subheadline)

                Text(viewModel.abstract)
                    .font(NYTFonts.body)

                Button(action: viewModel.toggleLike) {
                    Label(viewModel.likeButtonText, systemImage: viewModel.likeButtonIcon)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(NYTConstants.Colors.likeButtonBackground)
                        .cornerRadius(NYTConstants.Layout.buttonCornerRadius)
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }
            }
            .padding()
        }
        .navigationTitle(NYTConstants.Strings.detailsTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if let shareURL = viewModel.shareURL {
                    ShareLink(item: shareURL) {
                        Image(systemName: NYTConstants.ImageNames.shareIconName)
                    }
                }
            }
        }
        .onAppear {
            viewModel.checkIfLiked()
        }
    }
}
