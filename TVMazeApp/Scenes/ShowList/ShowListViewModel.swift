import Foundation
import Combine

class ShowListViewModel {
    
    let service: TVMazeService
    
    var shows: CurrentValueSubject<[ShowCellViewModel], Never> = .init([])
    var isLoading: CurrentValueSubject<Bool, Never> = .init(false)
    var loadError: CurrentValueSubject<Error?, Never> = .init(nil)
    
    var hasMorePages: Bool = true
    
    private var loadedShows: [Show] = []
    private var lastRequestedPage: Int = -1
    
    init(service: TVMazeService) {
        self.service = service
    }
    
    func loadShows() {
        guard hasMorePages, !isLoading.value else { return }
        
        isLoading.value = true
        loadError.value = nil
        
        lastRequestedPage += 1
        print("requesting page", lastRequestedPage)
        
        service.listShows(page: lastRequestedPage) { [self] result in
            switch result {
            case .success(let pageShows):
                loadedShows.append(contentsOf: pageShows)
                shows.value.append(contentsOf: pageShows.map(ShowCellViewModel.init(show:)))
            case .failure(let error):
                if case TVMazeError.noMorePages = error {
                    hasMorePages = false
                } else {
                    loadError.value = error
                }
            }
            
            isLoading.value = false
        }
    }
    
    func reloadShows() {
        shows.value = []
        lastRequestedPage = -1
        hasMorePages = true
        
        loadShows()
    }
    
}
