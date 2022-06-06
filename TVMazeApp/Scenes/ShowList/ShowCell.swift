import UIKit
import Kingfisher

class ShowCell: UITableViewCell, ViewCode, Reusable {
    
    // MARK: Views
    
    private let containerStackView = UIStackView()
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    
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
    }
    
    func setupConstraints() {
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 2/3),
            posterImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func configureViews() {
        containerStackView.axis = .horizontal
        containerStackView.distribution = .fill
        containerStackView.alignment = .fill
        containerStackView.spacing = 8
        
        titleLabel.numberOfLines = 0
    }
    
    // MARK: - Configuration
    
    func configure(viewModel: ShowCellViewModel) {
        posterImageView.kf.setImage(with: viewModel.posterUrl)
        titleLabel.text = viewModel.title
    }
    
}
