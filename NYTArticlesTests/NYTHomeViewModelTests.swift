//
//  NYTHomeViewModelTests.swift
//  NYTArticles
//
//  Created by Jeslin Johnson on 08/08/2025.
//


import XCTest
import Combine
@testable import NYTArticles

final class NYTHomeViewModelTests: XCTestCase {
    var viewModel: NYTHomeViewModel!
    var mockNetworkService: NYTMockNetworkService!
    var mockCacheManager: NYTMockCacheManager!

    override func setUp() {
        super.setUp()
        mockNetworkService = NYTMockNetworkService()
        mockCacheManager = NYTMockCacheManager()
        viewModel = NYTHomeViewModel(networkService: mockNetworkService, cacheManager: mockCacheManager)
    }

    func testFetchArticlesSuccess() {
        let article = NYTArticleModel(url: "https://test.com", title: "Test Article", abstract: nil, byline: "Author", published_date: "2025-08-08", media: nil)
        mockNetworkService.articlesToReturn = [article]

        let expectation = XCTestExpectation(description: "Fetch articles success")

        viewModel.$articles
            .dropFirst()
            .sink { articles in
                XCTAssertEqual(articles.count, 1)
                XCTAssertEqual(articles.first?.title, "Test Article")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchArticles(reset: true)

        wait(for: [expectation], timeout: 1)
    }

    func testLoadCachedArticles() {
        let article = NYTArticleModel(url: "https://cached.com", title: "Cached Article", abstract: nil, byline: "Cache Author", published_date: "2025-08-08", media: nil)
        mockCacheManager.articlesToLoad = [article]

        viewModel.loadCachedArticles()

        XCTAssertEqual(viewModel.articles.count, 1)
        XCTAssertEqual(viewModel.articles.first?.title, "Cached Article")
    }

    private var cancellables = Set<AnyCancellable>()
}
