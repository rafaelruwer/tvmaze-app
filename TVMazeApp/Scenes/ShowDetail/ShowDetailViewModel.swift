import Foundation
import Combine

class ShowDetailViewModel {
    
    // MARK: Properties
    
    var update: PassthroughSubject<Void, Never> = .init()
    
    var posterUrl: URL {
        show.poster.original
    }
    
    var title: String {
        show.title
    }
    
    var yearsActive: String {
        FormatterUtils.formatYearsActive(releaseDate: show.releaseDate, endDate: show.endDate)
    }
    
    var genresTags: [String] {
        show.genres
    }
    
    var description: String {
        FormatterUtils.removeHTMLTags(from: show.summary)
    }
    
    var schedule: String {
        show.schedule.map(FormatterUtils.formatSchedule(_:)) ?? "No schedule"
    }
    
    var runtime: String {
        FormatterUtils.formatRuntime(show.runtime)
    }
    
    var network: String {
        show.network
    }
    
    var rating: String {
        show.rating?.formatted() ?? "No rating"
    }
    
    var episodesBySeasons: [[ShowDetailEpisodeCellViewModel]] = []
    var isLoadingEpisodes: Bool = false
    
    var episodesModels: [[Episode]] { allEpisodes }
    
    // MARK: Private Properties
    
    private let service: TVMazeService
    private let show: Show
    private var allEpisodes: [[Episode]] = []
    
    // MARK: - Initializers
    
    init(service: TVMazeService, show: Show) {
        self.service = service
        self.show = show
    }
    
    // MARK: - Methods
    
    func loadEpisodes() {
        guard !isLoadingEpisodes else { return }
        
        isLoadingEpisodes = true
        update.send()
        
        service.listEpisodes(ofShow: show.id) { [self] result in
            switch result {
            case .success(let loadedEpisodes):
                let groupedBySeason = Dictionary(grouping: loadedEpisodes, by: \.season)
                    .sorted { $0.key < $1.key }
                    .map(\.value)
                
                allEpisodes = groupedBySeason
                episodesBySeasons = groupedBySeason.map { $0.map(ShowDetailEpisodeCellViewModel.init(episode:)) }
            case .failure:
                allEpisodes = []
                episodesBySeasons = []
            }
            
            isLoadingEpisodes = false
            update.send()
        }
    }
    
    func headerForSeason(_ season: Int) -> String {
        "Season \(season)"
    }
    
}
