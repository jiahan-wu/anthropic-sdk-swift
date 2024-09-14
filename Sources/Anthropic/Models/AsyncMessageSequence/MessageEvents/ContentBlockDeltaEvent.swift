//
//  ContentBlockDeltaEvent.swift
//
//
//  Created by Jia-Han Wu on 2024/9/14.
//

public struct ContentBlockDeltaEvent: Decodable {
    public struct Delta: Decodable {
        public let type: String
        public let text: String
    }
    
    public let type: String
    public let index: Int
    public let delta: Delta
}
