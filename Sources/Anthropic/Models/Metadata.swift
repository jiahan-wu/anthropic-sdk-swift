//
//  MessageMetadata.swift
//
//
//  Created by Jia-Han Wu on 2024/9/14.
//

public struct Metadata: Encodable {
    public init(userID: String?) {
        self.userID = userID
    }
    
    public let userID: String?
}
