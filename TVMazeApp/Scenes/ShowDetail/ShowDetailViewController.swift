import UIKit

class ShowDetailViewController: UIViewController, ViewCode {
    
    // MARK: Properties
    
    private let viewModel: ShowDetailViewModel
    
    // MARK: - Views
    
    private let tableView = UITableView()
    
    // MARK: - Initializers
    
    init(viewModel: ShowDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Code
    
    override func loadView() {
        self.view = UIView()
        applyViewCode()
    }
    
    func buildHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func configureViews() {
        view.backgroundColor = .systemBackground
        
        tableView.backgroundColor = .clear
        tableView.sectionHeaderTopPadding = 0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        
//        tableView.dataSource = self
//        tableView.delegate = self
    }
    
}

// MARK: - UITableViewDataSource
extension ShowDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        fatalError()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fatalError()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError()
    }
}

// MARK: - UITableViewDelegate
extension ShowDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected", indexPath)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
