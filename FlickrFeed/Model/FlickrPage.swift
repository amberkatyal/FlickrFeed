//
//  FlickrPage.swift
//  FlickrFeed
//
//  Created by Amber Katyal on 17/01/21.
//  Copyright © 2021 Amber Katyal. All rights reserved.
//

import Foundation

public struct FlickrPage: Decodable {
    public let page, pages, perpage, total: Int
    public let photo: [FlickrPhoto]
}
