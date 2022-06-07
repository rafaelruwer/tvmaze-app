import UIKit
import Combine

class ShowSearchViewController: UIViewController, ViewCode {
    
    // MARK: Properties
    
    private let viewModel: ShowSearchViewModel
    private var viewModelSubscription: AnyCancellable?
    
    // MARK: - Views
    
    private let tableView = UITableView()
    
    // MARK: - Initializers
    
    init(viewModel: ShowSearchViewModel) {
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
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func configureViews() {
        view.backgroundColor = .systemBackground
        
        tableView.backgroundColor = .clear
        tableView.sectionHeaderTopPadding = 0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 130
        
        tableView.register(cell: ShowSearchCell.self)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModelSubscription = viewModel.update.receive(on: DispatchQueue.main)
            .sink { _ in
                self.tableView.reloadData()
            }
    }
    
}

// MARK: - UITableViewDataSource
extension ShowSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.shows[indexPath.row]
        
        let cell: ShowSearchCell = tableView.dequeueCell(for: indexPath)
        cell.configure(viewModel: cellViewModel)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ShowSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected", indexPath)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UISearchResultsUpdating
extension ShowSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text ?? ""
        viewModel.search(query: query)
    }
}
