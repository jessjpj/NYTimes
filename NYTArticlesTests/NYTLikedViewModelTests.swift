//
//  NYTLikedViewModelTests.swift
//  NYTArticles
//
//  Created by Jeslin Johnson on 08/08/2025.
//

import XCTest
@testable import NYTArticles

final class NYTLikedViewModelTests: XCTestCase {
    var viewModel: NYTLikedViewModel!
    var mockContext: NYTMockPersistenceContext!

    override func setUp() {
        super.setUp()
        mockContext = NYTMockPersistenceContext()
        viewModel = NYTLikedViewModel(persistenceContext: mockContext)
    }

    func testLoadLikedArticles_success() {
        mockContext.likedArticlesToReturn = [
            NYTLikedArticle(
                article: NYTArticleModel(
                    url: nil,
                    title: "Title 1",
                    abstract: nil,
                    byline: "Author Name",
                    published_date: nil,
                    media: nil
                )
            )
        ]

        viewModel.loadLikedArticles()

        XCTAssertEqual(viewModel.articles.count, 1)
        XCTAssertEqual(viewModel.articles.first?.title, "Title 1")
    }

    func testLoadLikedArticles_failure() {
        mockContext.shouldThrowOnFetch = true
        viewModel.loadLikedArticles()
        XCTAssertEqual(viewModel.articles.count, 0)
    }
}
