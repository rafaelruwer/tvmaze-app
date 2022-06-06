import UIKit
import Combine

class ShowListViewController: UIViewController, ViewCode {
    
    // MARK: Properties
    
    let viewModel: ShowListViewModel
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Views
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let loadingIndicator = UIActivityIndicatorView(style: .medium)
    private let emptyStateLabel = UILabel()
    
    // MARK: - Initializers
    
    init(viewModel: ShowListViewModel) {
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
        view.addSubview(loadingIndicator)
        view.addSubview(tableView)
        view.addSubview(emptyStateLabel)
    }
    
    func setupConstraints() {
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func configureViews() {
        view.backgroundColor = .systemBackground
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .primaryActionTriggered)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(ShowCell.self, forCellReuseIdentifier: ShowCell.identifier)
    }
    
    func configureSubscriptions() {
        viewModel.isLoading.receive(on: DispatchQueue.main)
            .sink { [self] isLoading in
                if isLoading {
                    tableView.isHidden = true
                    loadingIndicator.startAnimating()
                    loadingIndicator.isHidden = false
                } else {
                    tableView.isHidden = false
                    loadingIndicator.isHidden = true
                    loadingIndicator.stopAnimating()
                }
            }
            .store(in: &subscriptions)
        
        // FIXME: handle load errors
        
        viewModel.shows.receive(on: DispatchQueue.main)
            .sink { _ in
                self.tableView.reloadData()
            }
            .store(in: &subscriptions)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubscriptions()
        viewModel.loadShows()
    }
    
    // MARK: - Actions
    
    @objc private func didPullToRefresh() {
        viewModel.reloadShows()
    }
}

// MARK: - UITableViewDataSource
extension ShowListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.shows.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.shows.value[indexPath.row]
        
        let cell: ShowCell = tableView.dequeueCell(for: indexPath)
        cell.configure(viewModel: cellViewModel)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ShowListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected", indexPath)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
