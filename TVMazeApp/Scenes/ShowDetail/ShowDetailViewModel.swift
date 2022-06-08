import Foundation

class ShowDetailViewModel {
    
    private let show: Show
    
    init(show: Show) {
        self.show = show
    }
    
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
        // remove html tags before returning
        let textData = Data(show.summary.utf8)
        let htmlString = try? NSAttributedString(data: textData,
                                                 options: [.documentType: NSAttributedString.DocumentType.html],
                                                 documentAttributes: nil)
        let noTagsString = htmlString?.string ?? show.summary
        return noTagsString.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var schedule: String {
        show.schedule.map(FormatterUtils.formatSchedule(_:)) ?? "No schedule"
    }
    
    var runtime: String {
        "60 min"
    }
    
    var network: String {
        show.network
    }
    
    var rating: String {
        show.rating?.formatted() ?? "No rating"
    }
    
}
