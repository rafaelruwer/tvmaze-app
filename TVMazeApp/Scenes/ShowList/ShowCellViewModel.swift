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
        "2011-2020"
    }
    
    var schedule: String {
        "Thu, 10pm"
    }
    
    var network: String {
        "CBS"
    }
    
    var rating: String {
        "6.8"
    }
    
}
