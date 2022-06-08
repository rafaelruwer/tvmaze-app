import UIKit
import Kingfisher

class ShowSearchCell: UITableViewCell, ViewCode, Reusable {
    
    // MARK: Views
    
    private let containerStackView = UIStackView()
    private let posterImageView = UIImageView()
    
    private let detailsStackView = UIStackView()
    private let titleLabel = UILabel()
    private let yearsActiveView = IconTextView()
    private let extraInfoView = IconTextView()
    
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
        containerStackView.addArrangedSubview(detailsStackView)
        
        detailsStackView.addArrangedSubview(titleLabel)
        detailsStackView.addArrangedSubview(yearsActiveView)
        detailsStackView.addArrangedSubview(extraInfoView)
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
        ])
    }
    
    func configureViews() {
        containerStackView.axis = .horizontal
        containerStackView.spacing = 8
        
        detailsStackView.axis = .vertical
        detailsStackView.alignment = .leading
        detailsStackView.setCustomSpacing(8, after: titleLabel)
        detailsStackView.setCustomSpacing(4, after: yearsActiveView)
        
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        [yearsActiveView, extraInfoView].forEach { detailView in
            detailView.iconSize = 20
            detailView.fontSize = 14
            detailView.spacing = 4
        }
        
        yearsActiveView.icon = UIImage(systemName: "calendar")
        extraInfoView.icon = UIImage(systemName: "info.circle")
    }
    
    // MARK: - Configuration
    
    func configure(viewModel: ShowSearchCellViewModel) {
        posterImageView.kf.setImage(with: viewModel.posterUrl)
        titleLabel.text = viewModel.title
        yearsActiveView.text = viewModel.airDate
        extraInfoView.text = viewModel.info
    }
}
