import UIKit
import Kingfisher

class ShowSearchResultCell: UITableViewCell, ViewCode, Reusable {
    
    // MARK: Views
    
    private let containerStackView = UIStackView()
    private let posterImageView = UIImageView()
    private let labelsStackView = UIStackView()
    private let titleLabel = UILabel()
    
    private let airDateStackView = UIStackView()
    private let airDateIconView = UIImageView()
    private let airDateLabel = UILabel()
    
    private let infoStackView = UIStackView()
    private let infoIconView = UIImageView()
    private let infoLabel = UILabel()
    
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
        containerStackView.addArrangedSubview(labelsStackView)
        
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(airDateStackView)
        labelsStackView.addArrangedSubview(infoStackView)
        
        airDateStackView.addArrangedSubview(airDateIconView)
        airDateStackView.addArrangedSubview(airDateLabel)
        
        infoStackView.addArrangedSubview(infoIconView)
        infoStackView.addArrangedSubview(infoLabel)
    }
    
    func setupConstraints() {
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let posterHeight = posterImageView.heightAnchor.constraint(equalToConstant: 78)
        posterHeight.priority = .init(rawValue: 999)
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 2/3),
            posterHeight,
            
            airDateIconView.widthAnchor.constraint(equalTo: airDateIconView.heightAnchor),
            airDateIconView.widthAnchor.constraint(equalToConstant: 16),
            infoIconView.widthAnchor.constraint(equalTo: infoIconView.heightAnchor),
            infoIconView.widthAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    func configureViews() {
        containerStackView.axis = .horizontal
        containerStackView.spacing = 8
        
        labelsStackView.axis = .vertical
        labelsStackView.alignment = .leading
        labelsStackView.setCustomSpacing(8, after: titleLabel)
        labelsStackView.setCustomSpacing(4, after: airDateStackView)
        
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        airDateStackView.axis = .horizontal
        airDateStackView.spacing = 4
        airDateIconView.image = UIImage(systemName: "calendar")?
            .withTintColor(.black, renderingMode: .alwaysOriginal)
        airDateLabel.font = .systemFont(ofSize: 13, weight: .regular)
        
        infoStackView.axis = .horizontal
        infoStackView.spacing = 4
        infoIconView.image = UIImage(systemName: "info.circle")?
            .withTintColor(.black, renderingMode: .alwaysOriginal)
        infoLabel.font = .systemFont(ofSize: 13, weight: .regular)
    }
    
    // MARK: - Configuration
    
    func configure(viewModel: ShowSearchResultCellViewModel) {
        posterImageView.kf.setImage(with: viewModel.posterUrl)
        titleLabel.text = viewModel.title
        airDateLabel.text = viewModel.airDate
        infoLabel.text = viewModel.info
    }
}
