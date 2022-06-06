import Foundation
import Combine

class ShowListViewModel {
    
    let service: TVMazeService
    
    var shows: CurrentValueSubject<[ShowCellViewModel], Never> = .init([])
    var isLoading: CurrentValueSubject<Bool, Never> = .init(false)
    var loadError: CurrentValueSubject<Error?, Never> = .init(nil)
    
    private var loadedShows: [Show] = []
    private var lastRequestedPage: Int = -1
    
    init(service: TVMazeService) {
        self.service = service
    }
    
    func loadShows() {
        isLoading.value = true
        loadError.value = nil
        
        lastRequestedPage += 1
        
        service.listShows(page: lastRequestedPage) { [self] result in
            switch result {
            case .success(let pageShows):
                loadedShows.append(contentsOf: pageShows)
                shows.value.append(contentsOf: pageShows.map(ShowCellViewModel.init(show:)))
            case .failure(let error):
                loadError.value = error
            }
            
            isLoading.value = false
        }
    }
    
    func reloadShows() {
        shows.value = []
        lastRequestedPage = -1
        
        loadShows()
    }
    
}

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
