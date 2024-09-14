//
//  ContentBlockStartEvent.swift
//
//
//  Created by Jia-Han Wu on 2024/9/14.
//

public struct ContentBlockStartEvent: Decodable {
    public struct ContentBlock: Decodable {
        public let type: String
        public let text: String
        
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case index
        case contentBlock = "content_block"
    }
    
    public let type: String
    public let index: Int
    public let contentBlock: ContentBlock
}
