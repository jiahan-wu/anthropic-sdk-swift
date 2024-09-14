## Usage

```swift
let apiKey = "..."

let anthropicClient = AnthropicClient(apiKey: apiKey)

let asyncMessageSequence = try await anthropicClient.createMessage(
    model: "claude-3-haiku-20240307",
    messages: [
        Input(
            role: .user,
            content: [
                .text("Hello, Claude.")
            ]
        )
    ],
    maxTokens: 4096
)

for try await message in asyncMessageSequence {
    
}
```
