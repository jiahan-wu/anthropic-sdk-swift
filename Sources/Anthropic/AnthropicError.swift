//
//  AnthropicError.swift
//  
//
//  Created by Jia-Han Wu on 2024/9/14.
//

import Foundation

public enum AnthropicError: Error {
    case invalidURL
    case invalidHTTPURLResponse
    case invalidResponse(HTTPURLResponse)
    case apiError
    case decodingError
    case internalError
    case errorEvent(ErrorEvent)
}
