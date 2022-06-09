import UIKit
import Kingfisher

class ShowCell: UITableViewCell, ViewCode, Reusable {
    
    // MARK: Views
    
    private let containerStackView = UIStackView()
    private let posterImageView = UIImageView()
    private let detailsContainerView = UIView()
    
    private let titleYearsStackView = UIStackView()
    private let titleLabel = UILabel()
    private let yearsLabel = UILabel()
    
    private let detailsStackView = UIStackView()
    private let scheduleView = IconTextView()
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
        containerStackView.addArrangedSubview(detailsContainerView)
        
        detailsContainerView.addSubview(titleYearsStackView)
        detailsContainerView.addSubview(detailsStackView)
        
        titleYearsStackView.addArrangedSubview(titleLabel)
        titleYearsStackView.addArrangedSubview(yearsLabel)
        
        detailsStackView.addArrangedSubview(scheduleView)
        detailsStackView.addArrangedSubview(networkView)
        detailsStackView.addArrangedSubview(ratingView)
    }
    
    func setupConstraints() {
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        titleYearsStackView.translatesAutoresizingMaskIntoConstraints = false
        detailsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 2/3),
            posterImageView.widthAnchor.constraint(equalToConstant: 100),
            
            titleYearsStackView.topAnchor.constraint(equalTo: detailsContainerView.topAnchor),
            titleYearsStackView.leadingAnchor.constraint(equalTo: detailsContainerView.leadingAnchor),
            titleYearsStackView.trailingAnchor.constraint(equalTo: detailsContainerView.trailingAnchor),
            
            detailsStackView.topAnchor.constraint(greaterThanOrEqualTo: titleYearsStackView.bottomAnchor, constant: 12),
            detailsStackView.bottomAnchor.constraint(equalTo: detailsContainerView.bottomAnchor),
            detailsStackView.leadingAnchor.constraint(equalTo: titleYearsStackView.leadingAnchor),
            detailsStackView.trailingAnchor.constraint(equalTo: titleYearsStackView.trailingAnchor),
        ])
    }
    
    func configureViews() {
        backgroundConfiguration = .clear()
        
        containerStackView.axis = .horizontal
        containerStackView.spacing = 16
        
        detailsContainerView.backgroundColor = .clear
        
        titleYearsStackView.axis = .vertical
        titleYearsStackView.alignment = .leading
        titleYearsStackView.spacing = 0
        
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        
        yearsLabel.font = .systemFont(ofSize: 16, weight: .regular)
        yearsLabel.textColor = .secondaryLabel
        
        detailsStackView.axis = .vertical
        detailsStackView.spacing = 4
        
        [scheduleView, networkView, ratingView].forEach { detailView in
            detailView.iconSize = 22
            detailView.fontSize = 14
            detailView.spacing = 4
        }
        
        scheduleView.icon = UIImage(systemName: "calendar")
        networkView.icon = UIImage(systemName: "tv")
        ratingView.icon = UIImage(systemName: "star")
    }
    
    // MARK: - Configuration
    
    func configure(viewModel: ShowCellViewModel) {
        posterImageView.kf.setImage(with: viewModel.posterUrl)
        
        titleLabel.text = viewModel.title
        yearsLabel.text = viewModel.yearsActive
        
        scheduleView.text = viewModel.schedule
        networkView.text = viewModel.network
        ratingView.text = viewModel.rating
    }
    
}
