import UIKit

final class MainCoordinator {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let service = TVMazeService()
        let viewModel = ShowListViewModel(service: service)
        let viewController = ShowListViewController(viewModel: viewModel)
        
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
}
