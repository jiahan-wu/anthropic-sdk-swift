# Anthropic Swift API Library

This library provides convenient access to the Anthropic REST API from Swift.


## Installation

1. Xcode > File > Add Package Dependencies
2. Add `https://github.com/jiahan-wu/anthropic-sdk-swift.git`
3. Select "Up to Next Major Version" with "1.0.0"

## Usage

```swift
import Anthropic

let apiKey = "..."

let anthropicClient = AnthropicClient(apiKey: apiKey)

let imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/a/a7/Camponotus_flavomarginatus_ant.jpg")!

let asyncMessageSequence = try await anthropicClient.createMessage(
    model: "claude-3-haiku-20240307",
    messages: [
        Input(
            role: .user,
            content: [
                .image(ImageContent(type: "base64", mediaType: "image/jpeg", data: Data(contentsOf: imageURL).base64EncodedString())),
                .text("Describe this image."),
            ]
        )
    ],
    maxTokens: 4096
)

for try await message in asyncMessageSequence {
    print(message.content)
}
```

## License

`anthropic-sdk-swift` is released under the MIT License. See the LICENSE file for more information.
