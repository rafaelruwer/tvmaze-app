import UIKit
import Kingfisher

class ShowDetailEpisodeCell: UITableViewCell, ViewCode, Reusable {
    
    // MARK: Views
    
    private let containerStackView = UIStackView()
    private let imageLabelsStackView = UIStackView()
    private let summaryLabel = UILabel()
    
    private let episodeImageView = UIImageView()
    
    private let labelsStackView = UIStackView()
    private let titleLabel = UILabel()
    private let runtimeLabel = UILabel()
    
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
        
        containerStackView.addArrangedSubview(imageLabelsStackView)
        containerStackView.addArrangedSubview(summaryLabel)
        
        imageLabelsStackView.addArrangedSubview(episodeImageView)
        imageLabelsStackView.addArrangedSubview(labelsStackView)
        
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(runtimeLabel)
    }
    
    func setupConstraints() {
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            episodeImageView.widthAnchor.constraint(equalTo: episodeImageView.heightAnchor, multiplier: 16/9),
            episodeImageView.widthAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    func configureViews() {
        containerStackView.axis = .vertical
        containerStackView.spacing = 8
        
        imageLabelsStackView.axis = .horizontal
        imageLabelsStackView.alignment = .center
        imageLabelsStackView.spacing = 12
        
        labelsStackView.axis = .vertical
        labelsStackView.alignment = .leading
        labelsStackView.spacing = 8
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        runtimeLabel.font = .systemFont(ofSize: 14, weight: .regular)
        
        summaryLabel.font = .systemFont(ofSize: 14, weight: .regular)
        summaryLabel.numberOfLines = 0
    }
    
    // MARK: - Configuration
    
    func configure(viewModel: ShowDetailEpisodeCellViewModel) {
        episodeImageView.kf.setImage(with: viewModel.imageUrl, options: [.onFailureImage(UIImage(named: "no-image"))])
        
        titleLabel.text = viewModel.title
        runtimeLabel.text = viewModel.runtime
        summaryLabel.text = viewModel.description
    }
    
}
