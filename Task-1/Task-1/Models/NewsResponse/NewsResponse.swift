//
//  NewsResponse.swift
//  Task-1
//
//  Created by Vasu Chovatiya on 30/11/23.
//

import Foundation

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [ArticleInfo]
    
    private enum CodingKeys: String, CodingKey {
        case status
        case totalResults
        case articles
    }
}
