import UIKit

final class MainCoordinator {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = ViewController()
        window.makeKeyAndVisible()
    }
    
}
