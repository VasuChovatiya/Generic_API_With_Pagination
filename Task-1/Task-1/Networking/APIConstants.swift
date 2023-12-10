//
//  APIConstants.swift
//  Task-1
//
//  Created by Vasu Chovatiya on 30/11/23.
//

import Foundation
struct APIConstants{
    static let baseURL: String                   = "https://newsapi.org/v2/"


    static let everthingBitcion: String     = "\(baseURL)everything?q=bitcoin&"
    static let apiKey: String                    = "apiKey=\(Application.API_KEY)&"
    //pagesize=10&Page=1

}

