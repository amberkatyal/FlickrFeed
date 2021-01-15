//
//  PlistKeys.swift
//  FlickrFeed
//
//  Created by Amber Katyal on 14/01/21.
//  Copyright © 2021 Amber Katyal. All rights reserved.
//

import Foundation

enum PlistKeys: String {
    case FLICKR_API_KEY
    case FLICKR_API_SECRET
    case FLICKR_API_BASE_URL
}

/// To support get values in Info.plist with key
///
/// - Parameter key: key of value that we want to get
/// - Returns: value of key that we gived
func infoForKey(_ key: PlistKeys) -> String {
    return (Bundle.main.infoDictionary?[key.rawValue] as? String)?
        .replacingOccurrences(of: "\\", with: "") ?? ""
}
