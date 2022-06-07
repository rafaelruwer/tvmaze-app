import UIKit

class ShowSearchResultCell: UITableViewCell, ViewCode, Reusable {
    
    // MARK: Views
    
    private let containerStackView = UIStackView()
    private let titleLabel = UILabel()
    private let airDateStackView = UIStackView()
    private let airDateIconView = UIImageView()
    private let airDateLabel = UILabel()
    private let infoStackView = UIStackView()
    private let infoIconView = UIImageView()
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
        
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(airDateLabel)
        containerStackView.addArrangedSubview(infoLabel)
    }
    
    func setupConstraints() {
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    func configureViews() {
        containerStackView.axis = .vertical
        containerStackView.distribution = .fill
        containerStackView.alignment = .leading
        
        containerStackView.setCustomSpacing(8, after: titleLabel)
        containerStackView.setCustomSpacing(5, after: airDateLabel)
        
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        airDateLabel.font = .systemFont(ofSize: 13, weight: .regular)
        infoLabel.font = .systemFont(ofSize: 13, weight: .regular)
    }
    
    // MARK: - Configuration
    
    func configure(viewModel: ShowSearchResultCellViewModel) {
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
