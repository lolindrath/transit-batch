import Foundation

struct Config: Codable {
    let apis: [String: APIs]
}

struct APIs: Codable {
    let backoff: Float
    let maxBackoff: Int
    let refreshInterval: Int
    let timeout: Int
}

let currentConfig = Config(apis:
    ["septa-api": APIs(
        backoff: 1.5,
        maxBackoff: 300,
        refreshInterval: 30,
        timeout: 15),
    "static-api": APIs(
        backoff: 1.5,
        maxBackoff: 300,
        refreshInterval: 30,
        timeout: 15)]
    )
