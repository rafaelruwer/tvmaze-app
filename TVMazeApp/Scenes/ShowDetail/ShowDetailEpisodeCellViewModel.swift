import Foundation

struct ShowDetailEpisodeCellViewModel {
    
    private let episode: Episode
    
    init(episode: Episode) {
        self.episode = episode
    }
    
    var imageUrl: URL? {
        episode.image?.thumbnail
    }
    
    var title: String {
        "\(episode.number) - \(episode.name)"
    }
    
    var rating: String {
        episode.rating?.formatted() ?? "No rating"
    }
}

