//
//  OAuthService.swift
//  FlickrFeed
//
//  Created by Amber Katyal on 16/01/21.
//  Copyright © 2021 Amber Katyal. All rights reserved.
//

import Foundation
import UIKit

final class OAuthService {
    
    private let consumerKey: String
    private let consumerSecret: String
    private let baseURL: String
    private let callbackURL: String
    private let signatureMethod = "HMAC-SHA1"
    private let oauthVersion = "1.0"
    private let allowedChars = CharacterSet.alphanumerics.union(CharacterSet(charactersIn: "._-~"))
    
    init(key: String = infoForKey(.FLICKR_API_KEY), secret: String = infoForKey(.FLICKR_API_SECRET), baseURL: String = infoForKey(.FLICKR_OAUTH_BASE_URL), callbackURL: String = "http://www.example.com") {
        self.consumerKey = key
        self.consumerSecret = secret
        self.baseURL = baseURL
        self.callbackURL = callbackURL
        requestToken()
    }
    
    func requestToken() {
        let timestamp = Int(Date().timeIntervalSince1970)
        let nonce = createNonce()
        let signature = createSignature(nonce: nonce, timestamp: timestamp)
        print(signature)
        let callbackEncodedURL = callbackURL.oauthEncoded
        let requestURL = baseURL + "/request_token?oauth_nonce=\(nonce)&oauth_timestamp=\(timestamp)&oauth_consumer_key=\(consumerKey)&oauth_signature_method=\(signatureMethod)&oauth_version=\(oauthVersion)&oauth_signature=\(signature)&oauth_callback=\(callbackEncodedURL)"
        print(requestURL)
        let url = URL(string: requestURL)!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let string = String(data: data, encoding: .utf8) {
                print(string)
            }
        }.resume()
    }
    
    // MARK: - Helpers
    private func createNonce() -> String {
        let uuidString: String = UUID().uuidString
        return String(uuidString.prefix(8))
    }
    
    private func createSignature(nonce: String, timestamp: Int) -> String {
        
        let encodedBaseURL = "\(baseURL)/request_token".oauthEncoded
        print("encoded BASE:")
        print(encodedBaseURL)
        
        let encodedParams = "oauth_callback=\(callbackURL.oauthEncoded)&oauth_consumer_key=\(consumerKey.oauthEncoded)&oauth_nonce=\(nonce)&oauth_signature_method=\(signatureMethod.oauthEncoded)&oauth_timestamp=\(timestamp)&oauth_version=\(oauthVersion.oauthEncoded)"
        let doubleEncodeParams = encodedParams.oauthEncoded
        
        let text = "\(HTTPMethod.get.rawValue)&\(encodedBaseURL)&\(doubleEncodeParams)"
        print(text)
        
        let key = "\(consumerSecret)&" // no token secret
        let signature = HMAC.sha1(key: key.data(using: .utf8)!, message: text.data(using: .utf8)!)!
        return signature.base64EncodedString()
    }
    
}

extension String {
    var oauthEncoded: String {
        let allowedChars = CharacterSet.alphanumerics.union(CharacterSet(charactersIn: "._-~"))
        return self.addingPercentEncoding(withAllowedCharacters: allowedChars)!
    }
}




