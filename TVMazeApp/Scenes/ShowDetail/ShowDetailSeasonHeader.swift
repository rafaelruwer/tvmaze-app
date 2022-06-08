import UIKit

class ShowDetailSeasonHeader: UITableViewHeaderFooterView, ViewCode, Reusable {
    
    // MARK: Views
    
    private let seasonLabel = UILabel()
    
    // MARK: - Initializers
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Code
    
    func buildHierarchy() {
        contentView.addSubview(seasonLabel)
    }
    
    func setupConstraints() {
        seasonLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            seasonLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            seasonLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            seasonLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            seasonLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    func configureViews() {
        seasonLabel.font = .systemFont(ofSize: 18, weight: .semibold)
    }
    
    // MARK: - Configuration
    
    func configure(text: String) {
        seasonLabel.text = text
    }
    
}
