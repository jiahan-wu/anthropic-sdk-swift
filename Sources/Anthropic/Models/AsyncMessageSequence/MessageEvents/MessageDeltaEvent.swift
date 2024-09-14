//
//  MessageDeltaEvent.swift
//  
//
//  Created by Jia-Han Wu on 2024/9/14.
//

struct MessageDeltaEvent: Decodable {
    struct Delta: Decodable {
        enum CodingKeys: String, CodingKey {
            case stopReason = "stop_reason"
            case stopSequence = "stop_sequence"
        }
        
        let stopReason: String?
        let stopSequence: String?
    }
        
    let type: String
    let delta: Delta
    let usage: Usage
}
