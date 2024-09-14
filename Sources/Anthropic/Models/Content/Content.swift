//
//  MessageContent.swift
//  
//
//  Created by Jia-Han Wu on 2024/9/14.
//

import Foundation

public enum Content: Codable, Sendable {
    enum CodingKeys: CodingKey {
        case type
        case text
        case source
    }
    
    case text(String)
    case image(ImageContent)
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let type = try container.decode(String.self, forKey: .type)
        
        switch type {
        case "text":
            let text = try container.decode(String.self, forKey: .text)
            self = .text(text)
        case "image":
            let imageContent = try container.decode(ImageContent.self, forKey: .source)
            self = .image(imageContent)
        default:
            throw AnthropicError.decodingError
        }
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
        case .text(let text):
            try container.encode("text", forKey: .type)
            try container.encode(text, forKey: .text)
        case .image(let image):
            try container.encode("image", forKey: .type)
            try container.encode(image, forKey: .source)
        }
    }
}
