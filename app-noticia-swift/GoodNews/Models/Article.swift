//
//  Article.swift
//  GoodNews
//

import Foundation

struct ArticleList: Decodable {
    let articles: [Article]
}
struct Article: Decodable {
    let title: String
    let description: String
    let url: String
}
