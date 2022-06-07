import Foundation
import SwiftyJSON

final class TVMazeService {
    
    private static let baseUrl: URL = URL(string: "https://api.tvmaze.com")!
    private let responseDecoder: TVMazeResponseDecoder = TVMazeResponseDecoder()
    
    func listShows(page: Int = 0, completion: @escaping (Result<[Show], Error>) -> Void) {
        guard let url = buildUrl(path: "shows", query: ["page": "\(page)"]) else {
            completion(.failure(TVMazeError.internal))
            return
        }
        
        performRequest(url: url, paginated: true, completion: completion) { [self] data in
            DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
                if page % 2 == 0 && page != 0 {
                    completion(.failure(TVMazeError.internal))
                    return
                }
                
                do {
                    let json = try JSON(data: data)
                    let shows = json.arrayValue.compactMap(responseDecoder.decodeShow(json:))
                    completion(.success(shows))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func searchShows(query: String, completion: @escaping (Result<[Show], Error>) -> Void) {
        guard let url = buildUrl(path: "search/shows", query: ["q": query]) else {
            completion(.failure(TVMazeError.internal))
            return
        }
        
        performRequest(url: url, paginated: false, completion: completion) { [self] data in
            do {
                let json = try JSON(data: data)
                let shows = json.arrayValue.map { $0["show"] }.compactMap(responseDecoder.decodeShow(json:))
                completion(.success(shows))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func listEpisodes(ofShow showId: Int, completion: @escaping (Result<[Episode], Error>) -> Void) {
        // TODO: missing implementation
        fatalError()
    }
    
}

extension TVMazeService {
    
    private func buildUrl(path: String, query: [String: String]) -> URL? {
        var urlComponents = URLComponents(url: Self.baseUrl.appendingPathComponent(path), resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = query.map { URLQueryItem(name: $0, value: $1) }
        return urlComponents?.url
    }
    
    private func performRequest<T>(url: URL, paginated: Bool, completion: @escaping (Result<T, Error>) -> Void, handleData: @escaping (Data) -> Void) {
        URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpUrlResponse = urlResponse as? HTTPURLResponse,
               !(200..<300).contains(httpUrlResponse.statusCode) {
                if paginated, httpUrlResponse.statusCode == 404 {
                    completion(.failure(TVMazeError.noMorePages))
                } else {
                    let responseBody = data.flatMap { String(data: $0, encoding: .utf8) }
                    completion(.failure(TVMazeError.http(code: httpUrlResponse.statusCode, response: responseBody)))
                }
                
                return
            }
            
            guard let data = data else {
                completion(.failure(TVMazeError.internal))
                return
            }
            
            handleData(data)
        }
        .resume()
    }
    
}
