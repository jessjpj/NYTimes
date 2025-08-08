//
//  NYTNetworkService.swift
//  NYTArticles
//
//  Created by Jeslin Johnson on 08/08/2025.
//


import Combine
import Foundation

final class NYTNetworkService: NYTNetworkServiceProtocol {
    static let shared = NYTNetworkService()
    private init() {}

    private let baseURL = NYTAPIConfiguration.shared.getBaseURLString()

    private let apiKey = NYTAPIConfiguration.shared.getAPIKey()

    func fetchMostViewedArticles(period: Int) -> AnyPublisher<NYTArticleResponseModel, Error> {
        guard let apiKey = apiKey else {
            return Fail(error: NSError(domain: "NYTAPI", code: -1, userInfo: [NSLocalizedDescriptionKey: "API key missing"]))
                .eraseToAnyPublisher()
        }
        
        let urlString = "\(baseURL)/\(period).json?api-key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard
                    let httpResponse = response as? HTTPURLResponse,
                    200..<300 ~= httpResponse.statusCode
                else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: NYTArticleResponseModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
