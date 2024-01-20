//
//  NetworkAPI.swift
//  Promova-iOS
//
//  Created by antonhoang on 19/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.

import Foundation
import Combine

protocol NetworkProtocol {
    func asyncRequest<T: Decodable>(endPoint: EndpointProvider, responseModel: T.Type) async throws -> T
}

class NetworkAPI: NetworkProtocol {
    
    private var session: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 300
        return URLSession(configuration: configuration)
    }
    
    func asyncRequest<T: Decodable>(endPoint: EndpointProvider, responseModel: T.Type) async throws -> T {
        let (data, response) = try await session.data(for: endPoint.asURLRequest())
        return try mapResponse(data: data, response: response)
    }
    
    func mapResponse<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        guard let response = response as? HTTPURLResponse else {
            throw APIError.unknown
        }
        switch response.statusCode {
        case 200...299:
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw APIError.decodingFailed
            }
        default:
            throw APIError.decodingFailed
        }
    }
    
}
