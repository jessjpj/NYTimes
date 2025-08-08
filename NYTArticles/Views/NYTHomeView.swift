//
//  NYTHomeView.swift
//  NYTArticles
//
//  Created by Jeslin Johnson on 08/08/2025.
//

import SwiftUI

struct NYTHomeView: View {
    @StateObject private var viewModel = NYTHomeViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.articles, id: \.id) { article in
                    NavigationLink(value: article) {
                        NYTArticleRow(article: article)
                            .onAppear {
                                viewModel.loadMoreIfNeeded(current: article)
                            }
                    }
                }
            }
            .refreshable {
                await viewModel.refresh()
            }
            .navigationTitle(NYTConstants.Strings.homeTitle)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        ForEach(NYTArticlePeriod.allCases) { period in
                            Button(action: {
                                viewModel.changePeriod(to: period)
                            }) {
                                Label(period.label, systemImage: viewModel.selectedPeriod == period ? "checkmark" : "")
                            }
                        }
                    } label: {
                        Image(systemName: NYTConstants.ImageNames.filterIconName)
                    }
                }
            }
            .navigationDestination(for: NYTArticleModel.self) { article in
                NYTArticleDetailView(article: article)
            }
        }
        .onAppear {
            viewModel.loadCachedArticles()
            viewModel.fetchArticles()
        }
    }
}

