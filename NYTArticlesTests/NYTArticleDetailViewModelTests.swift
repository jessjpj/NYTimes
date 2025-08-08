//
//  NYTArticleDetailViewModelTests.swift
//  NYTArticles
//
//  Created by Jeslin Johnson on 09/08/2025.
//


import XCTest
@testable import NYTArticles

@MainActor
final class NYTArticleDetailViewModelTests: XCTestCase {
    
    private var mockPersistenceContext: NYTMockPersistenceContext!
    private var sampleArticle: NYTArticleModel!
    private var viewModel: NYTArticleDetailViewModel!
    
    override func setUp() {
        super.setUp()
        mockPersistenceContext = NYTMockPersistenceContext()
        sampleArticle = NYTArticleModel(
            url: "https://example.com/article1",
            title: "Test Article",
            abstract: "Test Abstract",
            byline: "Test Author",
            published_date: "2024-01-01",
            media: nil
        )
        viewModel = NYTArticleDetailViewModel(
            article: sampleArticle,
            persistenceContext: mockPersistenceContext
        )
    }
    
    override func tearDown() {
        mockPersistenceContext = nil
        sampleArticle = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testCheckIfLiked_WhenArticleNotLiked_SetsIsLikedToFalse() {
        mockPersistenceContext.likedArticlesToReturn = []
        viewModel.checkIfLiked()

        XCTAssertFalse(viewModel.isLiked)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testCheckIfLiked_WhenArticleIsLiked_SetsIsLikedToTrue() {
        let likedArticle = NYTLikedArticle(article: sampleArticle)
        mockPersistenceContext.likedArticlesToReturn = [likedArticle]
        viewModel.checkIfLiked()

        XCTAssertTrue(viewModel.isLiked)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testCheckIfLiked_WhenFetchFails_SetsErrorMessage() {
        mockPersistenceContext.shouldThrowOnFetch = true
        viewModel.checkIfLiked()

        XCTAssertFalse(viewModel.isLiked)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.errorMessage!.contains("Failed to check liked status"))
    }
    
    func testToggleLike_WhenArticleNotLiked_LikesArticle() {
        mockPersistenceContext.likedArticlesToReturn = []
        viewModel.toggleLike()

        XCTAssertTrue(viewModel.isLiked)
        XCTAssertEqual(mockPersistenceContext.insertedArticles.count, 1)
        XCTAssertEqual(mockPersistenceContext.insertedArticles.first?.id, sampleArticle.id)
        XCTAssertEqual(mockPersistenceContext.deletedArticles.count, 0)
    }
    
    func testToggleLike_WhenArticleIsLiked_UnlikesArticle() {
        let likedArticle = NYTLikedArticle(article: sampleArticle)
        mockPersistenceContext.likedArticlesToReturn = [likedArticle]
        viewModel.toggleLike()

        XCTAssertFalse(viewModel.isLiked)
        XCTAssertEqual(mockPersistenceContext.deletedArticles.count, 1)
        XCTAssertEqual(mockPersistenceContext.deletedArticles.first?.id, sampleArticle.id)
        XCTAssertEqual(mockPersistenceContext.insertedArticles.count, 0)
    }
    
    func testComputedProperties() {
        XCTAssertEqual(viewModel.title, "Test Article")
        XCTAssertEqual(viewModel.byline, "Test Author")
        XCTAssertEqual(viewModel.abstract, "Test Abstract")
        XCTAssertEqual(viewModel.shareURL?.absoluteString, "https://example.com/article1")
    }
    
    func testLikeButtonText() {
        viewModel.isLiked = false
        XCTAssertEqual(viewModel.likeButtonText, NYTConstants.Strings.like)
        
        viewModel.isLiked = true
        XCTAssertEqual(viewModel.likeButtonText, NYTConstants.Strings.unlike)
    }
}
