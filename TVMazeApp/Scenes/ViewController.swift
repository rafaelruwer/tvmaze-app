import UIKit

class ViewController: UIViewController, ViewCode {
    
    private let label: UILabel = UILabel()
    
    override func loadView() {
        self.view = UIView()
        applyViewCode()
    }
    
    func buildHierarchy() {
        view.addSubview(label)
    }
    
    func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func configureViews() {
        view.backgroundColor = .systemBackground
        label.text = "Hello World!"
    }
    
}
