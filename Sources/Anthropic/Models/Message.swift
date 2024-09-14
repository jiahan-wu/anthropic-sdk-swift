//
//  Message.swift
//
//
//  Created by Jia-Han Wu on 2024/9/14.
//

import Foundation

public struct Message: Decodable, Sendable {
    enum CodingKeys: String, CodingKey {
        case content
        case id
        case model
        case role
        case stopReason = "stop_reason"
        case stopSequence = "stop_sequence"
        case type
        case usage
    }
    
    public var content: [Content]
    public var id: String
    public var model: String
    public var role: String
    public var stopReason: String?
    public var stopSequence: String?
    public var type: String
    public var usage: Usage
}
