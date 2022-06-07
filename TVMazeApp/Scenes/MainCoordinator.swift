import UIKit

final class MainCoordinator {
    
    private let window: UIWindow
    private var navigationController: UINavigationController!
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        navigationController = UINavigationController(rootViewController: getShowList())
        navigationController.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        navigationController.navigationBar.compactScrollEdgeAppearance = appearance
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    private func getShowList() -> UIViewController {
        let service = TVMazeService()
        let viewModel = ShowListViewModel(service: service)
        let viewController = ShowListViewController(viewModel: viewModel)
        
        // search
        let searchResultsController = getShowSearch()
        let searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchResultsUpdater = searchResultsController
        viewController.navigationItem.searchController = searchController
        viewController.definesPresentationContext = true
        
        return viewController
    }
    
    private func getShowSearch() -> UIViewController & UISearchResultsUpdating {
        let service = TVMazeService()
        let viewModel = ShowSearchViewModel(service: service)
        let viewController = ShowSearchViewController(viewModel: viewModel)
        
        return viewController
    }
    
}
