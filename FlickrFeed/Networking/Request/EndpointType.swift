//
//  EndpointType.swift
//  FlickrFeed
//
//  Created by Amber Katyal on 14/01/21.
//  Copyright © 2021 Amber Katyal. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

extension EndPointType {
    
    var baseURL: URL {
        let urlString = infoForKey(.FLICKR_API_BASE_URL)
        guard let url = URL(string: urlString) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var headers: HTTPHeaders? {
        return [:]
    }
}
