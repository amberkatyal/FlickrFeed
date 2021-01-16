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
    
    init(key: String = infoForKey(.FLICKR_API_KEY), secret: String = infoForKey(.FLICKR_API_SECRET), baseURL: String = infoForKey(.FLICKR_OAUTH_BASE_URL), callbackURL: String = "https://www.example.com") {
        self.consumerKey = "d1179b41a3b2639339e59f6591407667"
        self.consumerSecret = "a6a2a700741c8740"
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
        let requestURL = baseURL + "/request_token?oauth_consumer_key=\(consumerKey)&oauth_signature_method=\(signatureMethod)&oauth_timestamp=\(timestamp)&oauth_nonce=\(nonce)&oauth_version=\(oauthVersion)&oauth_signature=\(signature)&oauth_callback=\(callbackEncodedURL)"
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
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomCharacters = (0..<11).map{_ in characters.randomElement()!}
        let randomString = String(randomCharacters)
        return randomString
    }
    
    private func createSignature(nonce: String, timestamp: Int) -> String {
        
        let encodedBaseURL = "\(baseURL)/request_token".oauthEncoded
        
        let encodedParams = "oauth_callback=\(callbackURL.oauthEncoded)&oauth_consumer_key=\(consumerKey.oauthEncoded)&oauth_nonce=\(nonce)&oauth_signature_method=\(signatureMethod.oauthEncoded)&oauth_timestamp=\(timestamp)&oauth_version=\(oauthVersion.oauthEncoded)"
        let doubleEncodeParams = encodedParams.oauthEncoded
        
        let text = "\(HTTPMethod.get.rawValue)&\(encodedBaseURL)&\(doubleEncodeParams)"
        
        let key = "\(consumerSecret)&" // no token secret
        let signature = HMAC.sha1(key: key.data(using: .utf8)!, message: text.data(using: .utf8)!)!
        let signatureString = signature.base64EncodedString()
        // Issue in Postman, OAuthSwift etc: (RFC5849 oauth1)
        // While the encoding rules specified in this
//        specification for the purpose of constructing the signature base
//        string exclude the use of a "+" character (ASCII code 43) to
//        represent an encoded space character (ASCII code 32), this practice
//        is widely used in "application/x-www-form-urlencoded" encoded values,
//        and MUST be properly decoded.
        if signatureString.contains("+") {
            return createSignature(nonce: nonce, timestamp: Int(Date().timeIntervalSince1970))
        }
        return signatureString
    }
    
}

extension String {
    var oauthEncoded: String {
        let allowedChars = CharacterSet.alphanumerics.union(CharacterSet(charactersIn: "._-~"))
        return self.addingPercentEncoding(withAllowedCharacters: allowedChars)!
    }
}




