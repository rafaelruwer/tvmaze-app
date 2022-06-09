import Foundation

struct ShowSearchCellViewModel {
    
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
    
    var airDate: String {
        FormatterUtils.formatYearsActive(releaseDate: show.releaseDate, endDate: show.endDate)
    }
    
    var info: String {
        if let schedule = show.schedule {
            return "\(FormatterUtils.formatSchedule(schedule)) @ \(show.network)"
        } else {
            return show.network
        }
    }
    
}
