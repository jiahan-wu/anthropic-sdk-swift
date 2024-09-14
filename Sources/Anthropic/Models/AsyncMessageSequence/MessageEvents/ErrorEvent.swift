//
//  ErrorEvent.swift
//
//
//  Created by Jia-Han Wu on 2024/9/14.
//

public struct ErrorEvent: Decodable {
    public struct Error: Decodable {
        public let type: String
        public let message: String
        
    }
    
    public let type: String
    public let error: Error
}
