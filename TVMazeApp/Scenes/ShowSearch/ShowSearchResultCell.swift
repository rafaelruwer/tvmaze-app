import UIKit
import Kingfisher

class ShowSearchResultCell: UITableViewCell, ViewCode, Reusable {
    
    // MARK: Views
    
    private let containerStackView = UIStackView()
    private let posterImageView = UIImageView()
    private let labelsStackView = UIStackView()
    private let titleLabel = UILabel()
    private let airDateLabel = UILabel()
    private let infoLabel = UILabel()
    
    // MARK: - UI Components
    
    private lazy var calendarIconString: NSAttributedString = {
        let calendarIcon = UIImage(systemName: "calendar")
        let calendarAttachment = NSTextAttachment(image: calendarIcon ?? UIImage())
        return NSAttributedString(attachment: calendarAttachment)
    }()
    
    private lazy var infoIconString: NSAttributedString = {
        let infoIcon = UIImage(systemName: "info.circle")
        let infoAttachment = NSTextAttachment(image: infoIcon ?? UIImage())
        return NSAttributedString(attachment: infoAttachment)
    }()
    
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
        labelsStackView.addArrangedSubview(airDateLabel)
        labelsStackView.addArrangedSubview(infoLabel)
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
            posterHeight
        ])
    }
    
    func configureViews() {
        containerStackView.axis = .horizontal
        containerStackView.distribution = .fill
        containerStackView.alignment = .fill
        containerStackView.spacing = 8
        
        labelsStackView.axis = .vertical
        labelsStackView.distribution = .fill
        labelsStackView.alignment = .leading
        labelsStackView.setCustomSpacing(8, after: titleLabel)
        labelsStackView.setCustomSpacing(4, after: airDateLabel)
        
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        airDateLabel.font = .systemFont(ofSize: 13, weight: .regular)
        infoLabel.font = .systemFont(ofSize: 13, weight: .regular)
    }
    
    // MARK: - Configuration
    
    func configure(viewModel: ShowSearchResultCellViewModel) {
        posterImageView.kf.setImage(with: viewModel.posterUrl)
        titleLabel.text = viewModel.title
        
        // airDateLabel text
        let airDateString = NSMutableAttributedString()
        airDateString.append(calendarIconString)
        airDateString.append(NSAttributedString(string: " \(viewModel.airDate)"))
        airDateLabel.attributedText = airDateString
        
        // infoLabel text
        let infoString = NSMutableAttributedString()
        infoString.append(infoIconString)
        infoString.append(NSAttributedString(string: " \(viewModel.info)"))
        infoLabel.attributedText = infoString
    }
}
