import UIKit
import Kingfisher

class ShowDetailOverviewCell: UITableViewCell, ViewCode, Reusable {
    
    // MARK: Views
    
    private let containerStackView = UIStackView()
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let yearsActiveLabel = UILabel()
    private let summaryLabel = UILabel()
    
    private let detailsStackView = UIStackView()
    private let genresView = IconTextView()
    private let scheduleView = IconTextView()
    private let runtimeView = IconTextView()
    private let networkView = IconTextView()
    private let ratingView = IconTextView()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Code
    
    func buildHierarchy() {
        contentView.addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(posterImageView)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(yearsActiveLabel)
        containerStackView.addArrangedSubview(summaryLabel)
        containerStackView.addArrangedSubview(detailsStackView)
        
        detailsStackView.addArrangedSubview(genresView)
        detailsStackView.addArrangedSubview(scheduleView)
        detailsStackView.addArrangedSubview(runtimeView)
        detailsStackView.addArrangedSubview(networkView)
        detailsStackView.addArrangedSubview(ratingView)
    }
    
    func setupConstraints() {
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 2/3),
            posterImageView.widthAnchor.constraint(equalTo: containerStackView.widthAnchor, multiplier: 0.42),
            
            detailsStackView.widthAnchor.constraint(equalTo: containerStackView.widthAnchor),
        ])
    }
    
    func configureViews() {
        containerStackView.axis = .vertical
        containerStackView.alignment = .center
        containerStackView.spacing = 16
        containerStackView.setCustomSpacing(8, after: titleLabel)
        
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
        
        yearsActiveLabel.font = .systemFont(ofSize: 18, weight: .regular)
        yearsActiveLabel.textColor = .secondaryLabel
        yearsActiveLabel.textAlignment = .center
        
        summaryLabel.numberOfLines = 0
        summaryLabel.font = .systemFont(ofSize: 13, weight: .regular)
        
        detailsStackView.axis = .vertical
        detailsStackView.alignment = .leading
        detailsStackView.spacing = 4
        
        [genresView, scheduleView, runtimeView, networkView, ratingView].forEach { detailView in
            detailView.iconSize = 24
            detailView.fontSize = 16
            detailView.spacing = 8
        }
        
        genresView.icon = UIImage(named: "genre")
        scheduleView.icon = UIImage(systemName: "calendar")
        runtimeView.icon = UIImage(systemName: "clock")
        networkView.icon = UIImage(systemName: "tv")
        ratingView.icon = UIImage(systemName: "star")
    }
    
    // MARK: - Configuration
    
    func configure(viewModel: ShowDetailViewModel) {
        posterImageView.kf.setImage(with: viewModel.posterUrl)
        titleLabel.text = viewModel.title
        yearsActiveLabel.text = viewModel.yearsActive
        summaryLabel.text = viewModel.description
        genresView.text = viewModel.genres
        scheduleView.text = viewModel.schedule
        runtimeView.text = viewModel.runtime
        networkView.text = viewModel.network
        ratingView.text = viewModel.rating
    }
    
}
