//
//  InputMessage.swift
//  
//
//  Created by Jia-Han Wu on 2024/9/14.
//

import Foundation

public struct Input: Encodable, Sendable {
    public init(role: Role, content: [Content]) {
        self.role = role
        self.content = content
    }
    
    public let role: Role
    public let content: [Content]
}
