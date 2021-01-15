//
//  WebService.swift
//  FlickrFeed
//
//  Created by Amber Katyal on 15/01/21.
//  Copyright © 2021 Amber Katyal. All rights reserved.
//

import Foundation

enum NetworkResponse:String, Error {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

protocol WebService {
    
}

extension WebService {
    func parseAPIResponse(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Result<Any,NetworkResponse>) -> ()) {
        guard
            error == nil,
            let response = response as? HTTPURLResponse
        else {
            completion(.failure(.failed))
            return
        }
        if let responseError = self.handleNetworkResponse(response) {
            completion(.failure(responseError))
            return
        }
        guard let responseData = data else {
            completion(.failure(.noData))
            return
        }
        debugPrint(responseData)
        guard let jsonData = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) else {
            completion(.failure(.unableToDecode))
            return
        }
        debugPrint(jsonData)
        completion(.success(jsonData))
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> NetworkResponse? {
        debugPrint(response.statusCode)
        switch response.statusCode {
        case 200...299: return nil
        case 401...500: return .authenticationError
        case 501...599: return .badRequest
        case 600: return .outdated
        default: return .failed
        }
    }
}
