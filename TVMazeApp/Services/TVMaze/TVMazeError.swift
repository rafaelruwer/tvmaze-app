
enum TVMazeError: Error {
    case noMorePages
    
    case http(code: Int, response: String?)
    case `internal`
    case unexpected
}
