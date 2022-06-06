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
    
}
