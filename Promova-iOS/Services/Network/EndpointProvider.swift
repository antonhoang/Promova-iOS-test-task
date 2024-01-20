//
//  EndpointProvider.swift
//  Promova-iOS
//
//  Created by antonhoang on 20/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import Foundation

struct AnimalEndpoint: EndpointProvider {
    var scheme: String { "https" }
    var baseURL: String { "raw.githubusercontent.com" }
    var path: String { "/AppSci/promova-test-task-iOS/main/animals.json" }
    var method: RequestMethod { .get }
    var queryItems: [URLQueryItem]? = nil
    var body: [String : Any]? = nil
}


protocol EndpointProvider {
    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var body: [String: Any]? { get }
}

extension EndpointProvider {
    var scheme: String {
        return "https"
    }
    
    var baseURL: String {
        "raw.githubusercontent.com"
    }
}

extension EndpointProvider {
    func asURLRequest() throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host =  baseURL
        urlComponents.path = path
        if let queryItems = queryItems {
            urlComponents.queryItems = queryItems
        }
        guard let url = urlComponents.url else {
            throw APIError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("true", forHTTPHeaderField: "X-Use-Cache")
        if let body = body {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                throw APIError.unknown
            }
        }
        return urlRequest
    }
}
