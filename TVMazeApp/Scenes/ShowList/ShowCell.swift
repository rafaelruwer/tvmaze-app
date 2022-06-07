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
    
    private let labelsStackView = UIStackView()
    
    private let scheduleStackView = UIStackView()
    private let scheduleIconView = UIImageView()
    private let scheduleLabel = UILabel()
    
    private let networkStackView = UIStackView()
    private let networkIconView = UIImageView()
    private let networkLabel = UILabel()
    
    private let ratingStackView = UIStackView()
    private let ratingIconView = UIImageView()
    private let ratingLabel = UILabel()
    
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
        detailsContainerView.addSubview(labelsStackView)
        
        titleYearsStackView.addArrangedSubview(titleLabel)
        titleYearsStackView.addArrangedSubview(yearsLabel)
        
        labelsStackView.addArrangedSubview(scheduleStackView)
        labelsStackView.addArrangedSubview(networkStackView)
        labelsStackView.addArrangedSubview(ratingStackView)
        
        scheduleStackView.addArrangedSubview(scheduleIconView)
        scheduleStackView.addArrangedSubview(scheduleLabel)
        
        networkStackView.addArrangedSubview(networkIconView)
        networkStackView.addArrangedSubview(networkLabel)
        
        ratingStackView.addArrangedSubview(ratingIconView)
        ratingStackView.addArrangedSubview(ratingLabel)
    }
    
    func setupConstraints() {
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        titleYearsStackView.translatesAutoresizingMaskIntoConstraints = false
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        
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
            
            labelsStackView.topAnchor.constraint(greaterThanOrEqualTo: titleYearsStackView.bottomAnchor, constant: 12),
            labelsStackView.bottomAnchor.constraint(equalTo: detailsContainerView.bottomAnchor),
            labelsStackView.leadingAnchor.constraint(equalTo: titleYearsStackView.leadingAnchor),
            labelsStackView.trailingAnchor.constraint(equalTo: titleYearsStackView.trailingAnchor),
            
            scheduleIconView.widthAnchor.constraint(equalTo: scheduleIconView.heightAnchor),
            scheduleIconView.widthAnchor.constraint(equalToConstant: 22),
            
            networkIconView.widthAnchor.constraint(equalTo: networkIconView.heightAnchor),
            networkIconView.widthAnchor.constraint(equalToConstant: 22),
            
            ratingIconView.widthAnchor.constraint(equalTo: ratingIconView.heightAnchor),
            ratingIconView.widthAnchor.constraint(equalToConstant: 22),
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
        
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 4
        
        scheduleStackView.axis = .horizontal
        scheduleStackView.spacing = 4
        scheduleIconView.image = UIImage(systemName: "calendar")?
            .withTintColor(.black, renderingMode: .alwaysOriginal)
        scheduleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        
        networkStackView.axis = .horizontal
        networkStackView.spacing = 4
        networkIconView.image = UIImage(systemName: "tv")?
            .withTintColor(.black, renderingMode: .alwaysOriginal)
        networkLabel.font = .systemFont(ofSize: 14, weight: .regular)
        
        ratingStackView.axis = .horizontal
        ratingStackView.spacing = 4
        ratingIconView.image = UIImage(systemName: "star")?
            .withTintColor(.black, renderingMode: .alwaysOriginal)
        ratingLabel.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    // MARK: - Configuration
    
    func configure(viewModel: ShowCellViewModel) {
        posterImageView.kf.setImage(with: viewModel.posterUrl)
        
        titleLabel.text = viewModel.title
        yearsLabel.text = viewModel.yearsActive
        
        scheduleLabel.text = viewModel.schedule
        networkLabel.text = viewModel.network
        ratingLabel.text = viewModel.rating
    }
    
}
