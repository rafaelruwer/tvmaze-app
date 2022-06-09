import Foundation

struct ShowCellViewModel {
    
    private let show: Show
    
    init(show: Show) {
        self.show = show
    }
    
    var posterUrl: URL {
        show.poster.thumbnail
    }
    
    var title: String {
        show.title
    }
    
    var yearsActive: String {
        FormatterUtils.formatYearsActive(releaseDate: show.releaseDate, endDate: show.endDate)
    }
    
    var schedule: String {
        show.schedule.map(FormatterUtils.formatSchedule(_:)) ?? "No schedule"
    }
    
    var network: String {
        show.network
    }
    
    var rating: String {
        show.rating?.formatted() ?? "No rating"
    }
    
}
