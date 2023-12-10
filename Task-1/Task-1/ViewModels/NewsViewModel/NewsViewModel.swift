//
//  NewsViewModel.swift
//  Task-1
//
//  Created by Vasu Chovatiya on 30/11/23.
//

import Foundation


protocol NewsService: AnyObject {
    func reloadData()
}


class NewsViewModel {
    
    //MARK: - Properties
    var arrArticles: [ArticleInfo] = [] {
        didSet {
            self.delegate?.reloadData()
        }
    }
    
    weak var delegate: NewsService?
    
    var pageSize: Int = 10
    var currentPage: Int = 1
    
    //MARK: - Init
     init() {
         arrArticles.removeAll()
    }
    
    
    //MARK: - Functions
    @MainActor
    func loadMoreData() {
        self.currentPage = currentPage + 1
        self.fetchNewsArticles()
    }
    
    @MainActor
    func fetchNewsArticles() {
        Task { // @MainActor in
            do {
                let urlString = APIConstants.everthingBitcion + APIConstants.apiKey + "pagesize=\(pageSize)&Page=\(currentPage)"
                let newsResponseArray: NewsResponse = try await APIManager.shared.request(url: urlString)
                self.arrArticles.append(contentsOf: newsResponseArray.articles)
                DLog("articles fetched : - \(arrArticles)")
            } catch {
                print(error)
            }
        }
        
    }
    
}
