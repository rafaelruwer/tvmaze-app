import UIKit

class LoadingCell: UITableViewCell, ViewCode, Reusable {
    
    // MARK: Views
    
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
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
        contentView.addSubview(activityIndicator)
    }
    
    func setupConstraints() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            activityIndicator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    func configureViews() {
        backgroundConfiguration = .clear()
    }
    
    // MARK: - Configuration
    
    func animate() {
        activityIndicator.startAnimating()
    }
    
}
