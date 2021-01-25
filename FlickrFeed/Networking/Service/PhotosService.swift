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
    
    func fetchPopularPhotos(batchSize: Int, page: Int, completion: @escaping (Result<FlickrPage,NetworkResponse>)->Void) {
        router.request(.getPopular(batchSize: batchSize, page: page)) { (data, response, error) in
            self.parseAPIResponse(data: data, response: response, error: error) { (result) in
                let result = PhotoFeedMapper.map(data!, result: result)
                completion(result)
            }
        }
    }
    
}

internal final class PhotoFeedMapper {
    private struct Response: Decodable {
        let page: RemotePage
        
        enum CodingKeys: String, CodingKey {
            case page = "photos"
        }
    }
    
    private struct RemotePage: Decodable {
        public let page, pages, perpage, total: Int
        public let photo: [RemotePhoto]
        
        var flickrPage: FlickrPage {
            return FlickrPage(page: page, pages: pages, perpage: perpage, total: total, photo: photo.map { $0.photo })
        }
    }
    
    private struct RemotePhoto: Decodable {
        public let id: String
        public let title: String
        public let secret: String
        public let server: String
        
        var photo: FlickrPhoto {
            return FlickrPhoto(id: id, title: title, secret: secret, server: server)
        }
    }

    internal static func map(_ data: Data, result: Result<Any, NetworkResponse>) -> Result<FlickrPage, NetworkResponse>{
        switch result {
        case .success:
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                return .success(response.page.flickrPage)
            } catch {
                return .failure(.unableToDecode)
            }
        case .failure(let error):
            debugPrint(error)
            return .failure(error)
        }
    }
}
