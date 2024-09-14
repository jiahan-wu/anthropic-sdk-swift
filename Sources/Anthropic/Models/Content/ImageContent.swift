//
//  ImageContent.swift
//
//
//  Created by Jia-Han Wu on 2024/9/14.
//

public struct ImageContent: Codable, Sendable {
    enum CodingKeys: String, CodingKey {
        case type
        case mediaType = "media_type"
        case data
    }
    
    public init(type: String, mediaType: String, data: String) {
        self.type = type
        self.mediaType = mediaType
        self.data = data
    }
    
    public let type: String
    public let mediaType: String
    public let data: String
}
