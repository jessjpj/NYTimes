//
//  NYTNetworkServiceProtocol.swift
//  NYTArticles
//
//  Created by Jeslin Johnson on 08/08/2025.
//

import Combine

protocol NYTNetworkServiceProtocol {
    func fetchMostViewedArticles(period: Int) -> AnyPublisher<NYTArticleResponseModel, Error>
}
