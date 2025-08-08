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
    
    // MARK: - Published properties
    @Published private(set) var articles: [NYTArticleModel] = []
    @Published var selectedPeriod: NYTArticlePeriod = .thirtyDays
    @Published var selectedArticle: NYTArticleModel? = nil
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String? = nil
    
    // MARK: - Private properties
    private var currentPage = 0
    private var canLoadMorePages = true
    
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
    
    func fetchArticles(reset: Bool = false) {
        guard !isLoading else { return }
        
        if reset {
            currentPage = 0
            canLoadMorePages = true
            articles = []
        }
        
        guard canLoadMorePages else { return }
        
        isLoading = true
        errorMessage = nil
        
        currentPage += 1
        
        networkService.fetchMostViewedArticles(period: selectedPeriod.rawValue, page: currentPage)
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
                
                let fetchedArticles = response.results ?? []
                
                self.canLoadMorePages = !fetchedArticles.isEmpty
                
                if reset {
                    self.articles = fetchedArticles
                } else {
                    self.articles.append(contentsOf: fetchedArticles)
                }
                
                self.cacheManager.saveArticles(self.articles)
            }
            .store(in: &cancellables)
    }
    
    func loadMoreIfNeeded(current article: NYTArticleModel) {
        let thresholdIndex = articles.index(articles.endIndex, offsetBy: -5)
        if articles.firstIndex(where: { $0.id == article.id }) == thresholdIndex {
            fetchArticles()
        }
    }
    
    func changePeriod(to period: NYTArticlePeriod) {
        guard selectedPeriod != period else { return }
        selectedPeriod = period
        fetchArticles(reset: true)
    }
    
    func refresh() async {
        await withCheckedContinuation { continuation in
            fetchArticles(reset: true)
            continuation.resume()
        }
    }
    
    func loadCachedArticles() {
        articles = cacheManager.loadCachedArticles() ?? []
    }
}
