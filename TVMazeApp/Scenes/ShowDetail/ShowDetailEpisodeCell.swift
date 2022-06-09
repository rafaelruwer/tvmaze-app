import UIKit
import Kingfisher

class ShowDetailEpisodeCell: UITableViewCell, ViewCode, Reusable {
    
    // MARK: Views
    
    private let containerStackView = UIStackView()
    private let episodeImageView = UIImageView()
    
    private let labelsStackView = UIStackView()
    private let titleLabel = UILabel()
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
        
        containerStackView.addArrangedSubview(episodeImageView)
        containerStackView.addArrangedSubview(labelsStackView)
        
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(ratingView)
    }
    
    func setupConstraints() {
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let imageWidth = episodeImageView.widthAnchor.constraint(equalToConstant: 150)
        imageWidth.priority = .init(rawValue: 999)
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            episodeImageView.widthAnchor.constraint(equalTo: episodeImageView.heightAnchor, multiplier: 16/9),
            imageWidth,
        ])
    }
    
    func configureViews() {
        containerStackView.axis = .vertical
        containerStackView.spacing = 8
        
        containerStackView.axis = .horizontal
        containerStackView.alignment = .center
        containerStackView.spacing = 12
        
        labelsStackView.axis = .vertical
        labelsStackView.alignment = .leading
        labelsStackView.spacing = 8
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.numberOfLines = 0
        
        ratingView.icon = UIImage(systemName: "star")
        ratingView.iconSize = 22
        ratingView.fontSize = 14
        ratingView.spacing = 4
    }
    
    // MARK: - Configuration
    
    func configure(viewModel: ShowDetailEpisodeCellViewModel) {
        episodeImageView.kf.setImage(with: viewModel.imageUrl, options: [.onFailureImage(UIImage(named: "no-image"))])
        
        titleLabel.text = viewModel.title
        ratingView.text = viewModel.rating
    }
    
}
