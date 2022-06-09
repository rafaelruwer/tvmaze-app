import UIKit
import Kingfisher

class EpisodeDetailViewController: UIViewController, ViewCode {
    
    // MARK: Views
    
    private let episodeImageView = UIImageView()
    private let labelsStackView = UIStackView()
    private let detailLabel = UILabel()
    private let titleLabel = UILabel()
    private let summaryLabel = UILabel()
    
    // MARK: - Properties
    
    private let viewModel: EpisodeDetailViewModel
    
    // MARK: - Initializers
    
    init(viewModel: EpisodeDetailViewModel) {
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
        view.addSubview(episodeImageView)
        view.addSubview(labelsStackView)
        
        labelsStackView.addArrangedSubview(detailLabel)
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(summaryLabel)
    }
    
    func setupConstraints() {
        episodeImageView.translatesAutoresizingMaskIntoConstraints = false
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            episodeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodeImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            episodeImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            episodeImageView.widthAnchor.constraint(equalTo: episodeImageView.heightAnchor, multiplier: 16/9),
            
            labelsStackView.topAnchor.constraint(equalTo: episodeImageView.bottomAnchor, constant: 8),
            labelsStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            labelsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            labelsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
    
    func configureViews() {
        view.backgroundColor = .systemBackground
        
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 8
        labelsStackView.setCustomSpacing(16, after: titleLabel)
        
        detailLabel.font = .systemFont(ofSize: 18, weight: .regular)
        detailLabel.textColor = .secondaryLabel
        
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        
        summaryLabel.font = .systemFont(ofSize: 16, weight: .regular)
        summaryLabel.numberOfLines = 0
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = viewModel.name
        episodeImageView.kf.setImage(with: viewModel.episodeImageUrl, options: [.onFailureImage(UIImage(named: "no-image"))])
        detailLabel.text = viewModel.seasonEpisode
        titleLabel.text = viewModel.name
        summaryLabel.text = viewModel.description
    }
    
}
