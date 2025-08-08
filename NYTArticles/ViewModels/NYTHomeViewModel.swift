//
//  NYTHomeViewModel.swift
//  NYTArticles
//
//  Created by Jeslin Johnson on 08/08/2025.
//


import Foundation
import Combine

@MainActor
class NYTHomeViewModel: ObservableObject {
    
    @Published private(set) var articles: [NYTArticleModel] = []
    @Published var selectedPeriod: NYTArticlePeriod = .thirtyDays
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String? = nil
    
    private let networkService: NYTNetworkServiceProtocol
    private let cacheManager: NYTCacheManagerProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(networkService: NYTNetworkServiceProtocol = NYTNetworkService.shared,
         cacheManager: NYTCacheManagerProtocol = NYTCacheManager.shared) {
        self.networkService = networkService
        self.cacheManager = cacheManager
    }
    
    // MARK: - Public Methods
    
    func fetchArticles() {
        guard !isLoading else { return }
        articles = []
        
        isLoading = true
        errorMessage = nil
        
        networkService.fetchMostViewedArticles(period: selectedPeriod.rawValue)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
                
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                self.articles = response.results ?? []
                
                self.cacheManager.saveArticles(self.articles)
            }
            .store(in: &cancellables)
    }
    
    func changePeriod(to period: NYTArticlePeriod) {
        guard selectedPeriod != period else { return }
        selectedPeriod = period
        fetchArticles()
    }
    
    func refresh() async {
        await withCheckedContinuation { continuation in
            fetchArticles()
            continuation.resume()
        }
    }
    
    func loadCachedArticles() {
        articles = cacheManager.loadCachedArticles() ?? []
    }
}
