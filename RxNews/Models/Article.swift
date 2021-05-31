//
//  Article.swift
//  RxNews
//
//  Created by minho on 2021/05/27.
//

import Foundation

struct Article: Decodable {
    let title: String
    let description: String?
}

struct ArticleList: Decodable {
    let articles: [Article]
}

extension ArticleList {
    static var all: Resource<ArticleList> = {
        return Resource(url: url)
    }()
}
