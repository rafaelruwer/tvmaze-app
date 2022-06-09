import Foundation
import Combine

class ShowListViewModel {
    
    // MARK: Properties
    
    var update: PassthroughSubject<Void, Never> = .init()
    
    var shows: [ShowCellViewModel] = []
    var lastLoadError: Error?
    var hasMorePages: Bool = true
    
    var isPerformingInitialLoad: Bool { isLoading && currentPage == 0 }
    var showModels: [Show] { loadedShows }
    
    // MARK: Private Properties
    
    private let service: TVMazeService
    private var isLoading: Bool = false
    private var loadedShows: [Show] = []
    private var currentPage: Int = -1
    
    // MARK: - Initializer
    
    init(service: TVMazeService) {
        self.service = service
    }
    
    // MARK: - Methods
    
    func loadShows() {
        guard hasMorePages, !isLoading else { return }
        
        isLoading = true
        lastLoadError = nil
        
        currentPage += 1
        update.send()
        
        service.listShows(page: currentPage) { [self] result in
            switch result {
            case .success(let pageShows):
                loadedShows.append(contentsOf: pageShows)
                shows.append(contentsOf: pageShows.map(ShowCellViewModel.init(show:)))
            case .failure(let error):
                if case TVMazeError.noMorePages = error {
                    hasMorePages = false
                } else {
                    lastLoadError = error
                }
            }
            
            isLoading = false
            update.send()
            
            // if there was an error while fetching the page, wait and fetch the next one
            if lastLoadError != nil {
                DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                    self.loadShows()
                }
            }
        }
    }
    
    func reloadShows() {
        // reset state
        shows = []
        lastLoadError = nil
        hasMorePages = true
        isLoading = false
        loadedShows = []
        currentPage = -1
        
        loadShows()
    }
    
}
