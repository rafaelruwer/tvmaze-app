import UIKit

final class MainCoordinator {
    
    private let window: UIWindow
    private var navigationController: UINavigationController!
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let service = TVMazeService()
        let viewModel = ShowListViewModel(service: service)
        let viewController = ShowListViewController(viewModel: viewModel)
        
        navigationController = UINavigationController(rootViewController: viewController)
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
    
}
