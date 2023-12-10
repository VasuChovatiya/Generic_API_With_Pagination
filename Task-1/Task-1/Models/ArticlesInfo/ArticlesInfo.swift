//
//  ArticlesInfo.swift
//  Task-1
//
//  Created by Vasu Chovatiya on 30/11/23.
//

import Foundation

struct ArticleInfo: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    
    struct Source: Codable {
        let id: String?
        let name: String
        
        
        private enum CodingKeys: String, CodingKey {
            case id
            case name
        }
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
    }
    
    
    var formattedDateObj: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        return dateFormatter.date(from: self.publishedAt)
    }
    
    var imageURL: URL? {
        if let url = self.urlToImage {
            return URL(string: url)
        } else {
            return nil
        }
    }
    
    
    
}
