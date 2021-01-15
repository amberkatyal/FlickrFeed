//
//  PhotosAPI.swift
//  FlickrFeed
//
//  Created by Amber Katyal on 15/01/21.
//  Copyright © 2021 Amber Katyal. All rights reserved.
//

import Foundation

public enum PhotosAPI {
    case getPopular(batchSize: Int, page: Int)
}

extension PhotosAPI: EndPointType {
    var path: String {
        switch self {
        case .getPopular:
            return ""
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getPopular:
            return .get
        }
    }
    
    var urlParams: Parameters {
        return ["api_key" : infoForKey(.FLICKR_API_KEY), "format" : "json", "nojsoncallback" : "1"]
    }
    
    var task: HTTPTask {
        switch self {
        case .getPopular(let batchSize, let page):
            var params = urlParams
            params["per_page"] = batchSize
            params["page"] = page
            params["user_id"] = "152202925@N07"
            params["method"] = "flickr.photos.getPopular"
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: params)
        }
    }
    
    
}
