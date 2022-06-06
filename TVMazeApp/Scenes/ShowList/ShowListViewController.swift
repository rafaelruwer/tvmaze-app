import UIKit
import Combine

class ShowListViewController: UIViewController, ViewCode {
    
    // MARK: Properties
    
    let viewModel: ShowListViewModel
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Views
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let loadingIndicator = UIActivityIndicatorView(style: .medium)
    private let emptyStateLabel = UILabel()
    private let errorContainerView = UIView()
    private let errorLabel = UILabel()
    
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
        view.addSubview(errorContainerView)
        errorContainerView.addSubview(errorLabel)
    }
    
    func setupConstraints() {
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
        errorContainerView.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            
            emptyStateLabel.widthAnchor.constraint(equalToConstant: 300),
            emptyStateLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            
            errorContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            errorContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            errorLabel.topAnchor.constraint(equalTo: errorContainerView.topAnchor, constant: 8),
            errorLabel.bottomAnchor.constraint(equalTo: errorContainerView.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            errorLabel.leadingAnchor.constraint(equalTo: errorContainerView.leadingAnchor, constant: 16),
            errorLabel.trailingAnchor.constraint(equalTo: errorContainerView.trailingAnchor, constant: -16),
        ])
    }
    
    func configureViews() {
        navigationItem.title = "Shows"
        
        view.backgroundColor = .systemGroupedBackground
        
        tableView.backgroundColor = .clear
        tableView.sectionHeaderTopPadding = 0
        tableView.automaticallyAdjustsScrollIndicatorInsets = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .primaryActionTriggered)
        
        tableView.register(ShowCell.self, forCellReuseIdentifier: ShowCell.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        emptyStateLabel.numberOfLines = 0
        emptyStateLabel.textAlignment = .center
        emptyStateLabel.textColor = .secondaryLabel
        emptyStateLabel.text = "Failed to load shows. Pull down to try again."
        
        errorContainerView.backgroundColor = .systemRed
        errorLabel.textColor = .white
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
                    tableView.refreshControl?.endRefreshing()
                }
            }
            .store(in: &subscriptions)
        
        viewModel.loadError.receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [self] error in
                if let error = error {
                    errorContainerView.isHidden = false
                    errorLabel.text = "\(error)"
                } else {
                    errorContainerView.isHidden = true
                }
            })
            // hide errorContainerView 5 seconds after displaying
            .debounce(for: 5, scheduler: DispatchQueue.main)
            .sink { [self] error in
                if error != nil {
                    errorContainerView.isHidden = true
                }
            }
            .store(in: &subscriptions)
        
        viewModel.shows.receive(on: DispatchQueue.main)
            .sink { [self] shows in
                emptyStateLabel.isHidden = !shows.isEmpty
                tableView.reloadData()
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
