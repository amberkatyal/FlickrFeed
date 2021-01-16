//
//  PhotosService.swift
//  FlickrFeed
//
//  Created by Amber Katyal on 15/01/21.
//  Copyright © 2021 Amber Katyal. All rights reserved.
//

import Foundation

struct PhotosService: WebService {
    
    let router = Router<PhotosAPI>()
    
    func fetchPopularPhotos(batchSize: Int = 15, page: Int = 2) {
        router.request(.getPopular(batchSize: batchSize, page: page)) { (data, response, error) in
            self.parseAPIResponse(data: data, response: response, error: error) { (_) in
                
            }
        }
    }
    
}
