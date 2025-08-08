//
//  NYTLikedArticlesView.swift
//  NYTArticles
//
//  Created by Jeslin Johnson on 08/08/2025.
//

import SwiftUI
import SwiftData

struct NYTLikedArticlesView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: NYTLikedViewModel

    init(context: ModelContext) {
        let adapter = NYTModelContextAdapter(context: context)
        _viewModel = StateObject(wrappedValue: NYTLikedViewModel(persistenceContext: adapter))
    }
    
    var body: some View {
        NavigationStack {
            List(viewModel.articles, id: \.id) { article in
                NavigationLink(value: article) {
                    NYTArticleRow(article: article)
                }
            }
            .navigationTitle(NYTConstants.Strings.likedTitle)
            .navigationDestination(for: NYTArticleModel.self) { article in
                NYTArticleDetailView(article: article)
            }
            .onAppear {
                viewModel.loadLikedArticles()
            }
        }
    }
}
