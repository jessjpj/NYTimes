//
//  NYTMockNetworkService.swift
//  NYTArticles
//
//  Created by Jeslin Johnson on 08/08/2025.
//


import Combine
@testable import NYTArticles
import Foundation

final class NYTMockNetworkService: NYTNetworkServiceProtocol {
    var shouldReturnError = false
    var articlesToReturn: [NYTArticleModel] = []

    func fetchMostViewedArticles(period: Int, page: Int) -> AnyPublisher<NYTArticleResponseModel, Error> {
        if shouldReturnError {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }

        let response = NYTArticleResponseModel(results: articlesToReturn)

        return Just(response)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
