//
//  MessageStartEvent.swift
//
//
//  Created by Jia-Han Wu on 2024/9/14.
//

struct MessageStartEvent: Decodable {
    let type: String
    let message: Message
}
