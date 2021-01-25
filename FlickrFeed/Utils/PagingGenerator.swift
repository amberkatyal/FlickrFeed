//
//  PagingGenerator.swift
//  FlickrFeed
//
//  Created by Amber Katyal on 17/01/21.
//  Copyright © 2021 Amber Katyal. All rights reserved.
//

import Foundation

protocol AsyncGeneratorType {
    associatedtype Page
    associatedtype Fetch
    mutating func next(fetchNextBatch: Fetch,  onFinish: ((Page) -> Void)?)
}

class PagingGenerator<T>: AsyncGeneratorType {
    typealias Page = Array<T>
    typealias Fetch = (_ page: Int, _ limit: Int, _ completion:  @escaping (Page) -> Void) -> Void
        
    var page: Int
    let limit: Int
    
    init(page: Int = 1, limit: Int = 25) {
        self.page = page
        self.limit = limit
    }
    
    func next(fetchNextBatch: Fetch, onFinish: ((Page) -> Void)? = nil) {
        fetchNextBatch(page, limit) { [unowned self] (items) in
            onFinish?(items)
            self.page = items.count
        }
    }
}
