//
//  FlickrPhoto.swift
//  FlickrFeed
//
//  Created by Amber Katyal on 15/01/21.
//  Copyright © 2021 Amber Katyal. All rights reserved.
//

import Foundation

public struct FlickrPhoto: Decodable {
    public let id: String
    public let title: String
    public let secret: String
    public let server: String
    
    public var imageURL: URL {
        return URL(string: "https://live.staticflickr.com/\(server)/\(id)_\(secret).jpg")!
    }
}
