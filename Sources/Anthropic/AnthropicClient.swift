//
//  AnthropicClient.swift
//
//
//  Created by Jia-Han Wu on 2024/9/14.
//

import Foundation

public struct AnthropicClient: Sendable {
    public init(
        baseURL: URL = URL(string: "https://api.anthropic.com")!,
        apiKey: String,
        session: URLSession = .shared
    ) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.session = session
    }
    
    private let baseURL: URL
    
    public let apiKey: String
    
    private let session: URLSession
    
    public func createMessage(
        anthropicBeta: String? = nil,
        anthropicVersion: String = "2023-06-01",
        model: String,
        messages: [Input],
        maxTokens: Int,
        metadata: Metadata? = nil,
        stopSequences: [String]? = nil,
        system: String? = nil,
        temperature: Double? = nil,
        toolChoice: Any? = nil,
        tools: [Any]? = nil,
        topK: Int? = nil,
        topP: Double? = nil
    ) async throws -> AsyncMessageSequence<AsyncLineSequence<URLSession.AsyncBytes>> {
        struct Body: Encodable {
            enum CodingKeys: String, CodingKey {
                case model
                case messages
                case maxTokens = "max_tokens"
                case metadata
                case stopSequences = "stop_sequences"
                case stream
                case system
                case temperature
                case topK = "top_k"
                case topP = "top_p"
            }
            
            let model: String
            let messages: [Input]
            let maxTokens: Int
            let metadata: Metadata?
            let stopSequences: [String]?
            let stream: Bool
            let system: String?
            let temperature: Double?
            // let toolChoice: Any?
            // let tools: [Any]?
            let topK: Int?
            let topP: Double?
        }
        
        guard let url = URL(string: "/v1/messages", relativeTo: baseURL) else {
            throw AnthropicError.invalidURL
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        if let anthropicBeta {
            request.setValue(anthropicBeta, forHTTPHeaderField: "anthropic-beta")
        }
        
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        
        request.setValue(anthropicVersion, forHTTPHeaderField: "anthropic-version")
        
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        let body = Body(
            model: model,
            messages: messages,
            maxTokens: maxTokens,
            metadata: metadata,
            stopSequences: stopSequences,
            stream: true,
            system: system,
            temperature: temperature,
            topK: topK,
            topP: topP
        )
        
        request.httpBody = try! JSONEncoder().encode(body)
        
        let (bytes, response) = try await session.bytes(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw AnthropicError.invalidHTTPURLResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw AnthropicError.invalidResponse(httpResponse)
        }
        
        return bytes.lines.messages
    }
}


