//
//  NYTLikedArticlesView.swift
//  NYTArticles
//
//  Created by Jeslin Johnson on 08/08/2025.
//

import SwiftUI

struct NYTLikedArticlesView: View {
    @StateObject private var viewModel = NYTLikedViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.articles, id: \.id) { article in
                    NYTArticleRow(article: article)
                        .onTapGesture {
                            viewModel.selectedArticle = article
                        }
                }
            }
            .navigationTitle("Liked Articles")
            .background(
                NavigationLink(
                    destination: NYTArticleDetailView(article: viewModel.selectedArticle),
                    isActive: Binding(
                        get: { viewModel.selectedArticle != nil },
                        set: { active in
                            if !active { viewModel.selectedArticle = nil }
                        }
                    )
                ) {
                    EmptyView()
                }
                .hidden()
            )
            .onAppear {
                viewModel.loadLikedArticles()
            }
        }
    }
}
