import Foundation
import Combine

class ShowSearchViewModel {
    
    // MARK: Properties
    
    let update: PassthroughSubject<Void, Never> = .init()
    var shows: [ShowSearchCellViewModel] = []
    
    var showModels: [Show] { searchedShows }
    
    // MARK: Private Properties
    
    private let service: TVMazeService
    private var searchQuery: CurrentValueSubject<String, Never> = .init("")
    private var searchedShows: [Show] = []
    private var searchSubscription: AnyCancellable?
    
    // MARK: - Initializer
    
    init(service: TVMazeService) {
        self.service = service
        
        setupSearchSubscription()
    }
    
    // MARK: - Methods
    
    func search(query: String) {
        searchQuery.value = query
    }
    
    private func setupSearchSubscription() {
        searchSubscription = searchQuery
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] query in
                self?.service.searchShows(query: query) { [weak self] result in
                    switch result {
                    case .success(let queriedShows):
                        self?.searchedShows = queriedShows
                        self?.shows = queriedShows.map(ShowSearchCellViewModel.init(show:))
                    case .failure:
                        self?.searchedShows = []
                        self?.shows = []
                    }
                    
                    self?.update.send()
                }
            }
    }
    
}
