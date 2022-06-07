import Foundation

struct Show: Equatable {
    let id: Int
    let title: String
    let summary: String
    
    let genres: [String]
    let schedule: Schedule?
    let network: String
    let releaseDate: Date
    let endDate: Date?
    
    let poster: ImageRef
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct Schedule: Equatable {
    let time: String
    let days: [String]
}
