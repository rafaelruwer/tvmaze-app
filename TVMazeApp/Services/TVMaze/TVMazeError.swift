
enum TVMazeError: Error {
    case `internal`
    case http(code: Int, response: String?)
    case unexpected
}
