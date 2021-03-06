import UIKit
import Combine

class ShowDetailViewController: UIViewController, ViewCode {
    
    // MARK: Properties
    
    var coordinator: MainCoordinator?
    
    private let viewModel: ShowDetailViewModel
    private var viewModelSubscription: AnyCancellable?
    
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
        navigationItem.largeTitleDisplayMode = .never
        
        view.backgroundColor = .systemBackground
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        
        tableView.register(headerFooter: ShowDetailSeasonHeader.self)
        tableView.register(cell: ShowDetailOverviewCell.self)
        tableView.register(cell: ShowDetailEpisodesHeaderCell.self)
        tableView.register(cell: ShowDetailEpisodeCell.self)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModelSubscription = viewModel.update.receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
        
        viewModel.loadEpisodes()
        
        navigationItem.title = viewModel.title
    }
    
}

// MARK: - UITableViewDataSource
extension ShowDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1 + viewModel.episodesBySeasons.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return viewModel.episodesBySeasons[section - 1].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell: ShowDetailOverviewCell = tableView.dequeueCell(for: indexPath)
                cell.configure(viewModel: viewModel)
                return cell
            } else {
                let cell: ShowDetailEpisodesHeaderCell = tableView.dequeueCell(for: indexPath)
                cell.configure(isLoading: viewModel.isLoadingEpisodes)
                return cell
            }
        } else {
            let cellViewModel = viewModel.episodesBySeasons[indexPath.section - 1][indexPath.row]
            let cell: ShowDetailEpisodeCell = tableView.dequeueCell(for: indexPath)
            cell.configure(viewModel: cellViewModel)
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension ShowDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        
        let header: ShowDetailSeasonHeader = tableView.dequeueHeaderFooter()
        header.configure(text: viewModel.headerForSeason(section))
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        indexPath.section != 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = viewModel.episodesModels[indexPath.section - 1][indexPath.row]
        coordinator?.episodeDetails(episode: episode)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
