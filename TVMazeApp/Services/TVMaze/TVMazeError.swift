import Foundation

enum TVMazeError: LocalizedError {
    case noMorePages
    
    case http(code: Int, response: String?)
    case `internal`
    
    var errorDescription: String? {
        switch self {
        case .noMorePages:
            return "No more pages to be loaded."
        case .http(let code, let response):
            if let response = response {
                return "HTTP \(code): \(response)"
            } else {
                return "HTTP \(code)"
            }
        case .internal:
            return "An internal error happened. Please try again later."
        }
    }
}
