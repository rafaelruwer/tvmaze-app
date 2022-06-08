import Foundation

struct EpisodeDetailViewModel {
    
    private let episode: Episode
    
    init(episode: Episode) {
        self.episode = episode
    }
    
    var episodeImageUrl: URL? {
        episode.image?.original
    }
    
    var name: String {
        episode.name
    }
    
    var seasonEpisode: String {
        "Season \(episode.season), Episode \(episode.number)"
    }
    
    var description: String {
        FormatterUtils.removeHTMLTags(from: episode.summary)
    }
    
}
