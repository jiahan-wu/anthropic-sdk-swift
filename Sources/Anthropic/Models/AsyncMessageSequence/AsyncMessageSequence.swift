//
//  AsyncMessageEventSequence.swift
//
//
//  Created by Jia-Han Wu on 2024/9/14.
//

import Foundation

public struct AsyncMessageSequence<Base: AsyncSequence>: AsyncSequence where Base.Element == String {
    public typealias Element = Message
    
    internal init(underlyingSequence: Base) {
        base = underlyingSequence
    }
    
    private var base: Base
    
    public struct AsyncIterator: AsyncIteratorProtocol {
        public typealias Element = Message
        
        private var lineSource: Base.AsyncIterator
        
        private let jsonDecoder = JSONDecoder()
        
        private var previousMessage: Message?
        
        internal init(underlyingIterator: Base.AsyncIterator) {
            lineSource = underlyingIterator
        }
        
        public mutating func next() async throws -> Message? {
            var event: String?
            
            while let line = try await lineSource.next() {
                switch line {
                case let line where line.starts(with: "event:"):
                    event = line.trimmingCharacters(in: .whitespaces)
                case let line where line.starts(with: "data:"):
                    guard let event else {
                        throw AnthropicError.apiError
                    }
                    
                    let data = Data(line.dropFirst(5).trimmingCharacters(in: .whitespaces).utf8)
                    
                    switch event {
                    case "event: message_start":
                        let event = try jsonDecoder.decode(MessageStartEvent.self, from: data)
                        
                        previousMessage = event.message
                        
                        return event.message
                    case "event: content_block_start":
                        guard var message = previousMessage else {
                            throw AnthropicError.internalError
                        }
                        
                        let event = try jsonDecoder.decode(ContentBlockStartEvent.self, from: data)
                        
                        if event.contentBlock.type == "text" {
                            message.content.append(.text(""))
                        }
                        
                        previousMessage = message
                        
                        return message
                    case "event: content_block_delta":
                        guard var message = previousMessage else {
                            throw AnthropicError.internalError
                        }
                        
                        let event = try jsonDecoder.decode(ContentBlockDeltaEvent.self, from: data)
                        
                        guard case Content.text(let text) = message.content[event.index] else {
                            throw AnthropicError.internalError
                        }
                        
                        message.content[event.index] = .text(text + event.delta.text)
                        
                        previousMessage = message
                        
                        return message
                    case "event: content_block_stop":
                        continue
                    case "event: message_delta":
                        guard var message = previousMessage else {
                            throw AnthropicError.internalError
                        }
                        
                        let event = try jsonDecoder.decode(MessageDeltaEvent.self, from: data)
                        
                        message.stopReason = event.delta.stopReason
                        message.stopSequence = event.delta.stopSequence
                        message.usage.outputTokens = event.usage.outputTokens
                        
                        previousMessage = message
                        
                        return message
                    case "event: message_stop":
                        return nil
                    case "event: error":
                        let event = try jsonDecoder.decode(ErrorEvent.self, from: data)
                        
                        throw AnthropicError.errorEvent(event)
                    case "event: ping":
                        continue
                    default:
                        throw AnthropicError.apiError
                    }
                default:
                    throw AnthropicError.apiError
                }
            }
            
            return nil
        }
    }
    
    public func makeAsyncIterator() -> AsyncIterator {
        return AsyncIterator(underlyingIterator: base.makeAsyncIterator())
    }
}

extension AsyncMessageSequence : Sendable where Base : Sendable {}

extension AsyncSequence where Self.Element == String {
    var messages: AsyncMessageSequence<Self> {
        AsyncMessageSequence(underlyingSequence: self)
    }
}
