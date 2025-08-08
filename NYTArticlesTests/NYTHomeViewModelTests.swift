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
    private var cancellables = Set<AnyCancellable>()

    override func setUp() async throws {
        mockNetworkService = NYTMockNetworkService()
        mockCacheManager = NYTMockCacheManager()
        viewModel = await NYTHomeViewModel(networkService: mockNetworkService, cacheManager: mockCacheManager)
    }

    func testFetchArticlesSuccess() async throws {
        let article = NYTArticleModel(url: "https://test.com", title: "Test Article", abstract: nil, byline: "Author", published_date: "2025-08-08", media: nil)
        mockNetworkService.articlesToReturn = [article]

        let expectation = expectation(description: "Fetch articles success")

        let cancellable = await MainActor.run {
            viewModel.$articles
                .dropFirst()
                .first(where: { $0.count == 1 && $0.first?.title == "Test Article" })
                .sink { _ in
                    expectation.fulfill()
                }
        }

        await viewModel.fetchArticles(reset: true)

        await fulfillment(of: [expectation], timeout: 1)
        cancellable.cancel()
    }


    func testLoadCachedArticles() async throws {
        let article = NYTArticleModel(url: "https://cached.com", title: "Cached Article", abstract: nil, byline: "Cache Author", published_date: "2025-08-08", media: nil)
        mockCacheManager.articlesToLoad = [article]

        await viewModel.loadCachedArticles()

        await MainActor.run {
            XCTAssertEqual(viewModel.articles.count, 1)
            XCTAssertEqual(viewModel.articles.first?.title, "Cached Article")
        }
    }
}
