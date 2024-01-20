//
//  ApiError.swift
//  Promova-iOS
//
//  Created by antonhoang on 20/01/2024.
//  Copyright © 2024 antonhoang. All rights reserved.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case decodingFailed
    case requestFailed(String)
    case unexpectedStatusCode
    case unknown
}
