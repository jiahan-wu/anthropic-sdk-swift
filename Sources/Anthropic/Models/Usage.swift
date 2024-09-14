//
//  Usage.swift
//
//
//  Created by Jia-Han Wu on 2024/9/14.
//

public struct Usage: Decodable, Sendable {
    enum CodingKeys: String, CodingKey {
        case inputTokens = "input_tokens"
        case outputTokens = "output_tokens"
    }
    
    public var inputTokens: Int?
    public var outputTokens: Int?
}
