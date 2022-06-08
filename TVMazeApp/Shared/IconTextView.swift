import UIKit

class IconTextView: UIView, ViewCode {
    
    // MARK: Views
    
    private let stackView = UIStackView()
    private let iconImageView = UIImageView()
    private let textLabel = UILabel()
    
    private var iconWidthConstraint: NSLayoutConstraint!
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Code
    
    func buildHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(textLabel)
    }
    
    func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        iconWidthConstraint = iconImageView.widthAnchor.constraint(equalToConstant: 20)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor),
            iconWidthConstraint,
        ])
    }
    
    func configureViews() {
        stackView.axis = .horizontal
    }
    
    // MARK: - Configuration
    
    var icon: UIImage? {
        get {
            iconImageView.image
        }
        set {
            iconImageView.image = newValue?.withTintColor(.black, renderingMode: .alwaysOriginal)
        }
    }
    
    var iconSize: CGFloat {
        get {
            iconWidthConstraint.constant
        }
        set {
            iconWidthConstraint.constant = newValue
        }
    }
    
    var text: String {
        get {
            textLabel.text ?? ""
        }
        set {
            textLabel.text = newValue
        }
    }
    
    var fontSize: CGFloat {
        get {
            textLabel.font.pointSize
        }
        set {
            textLabel.font = .systemFont(ofSize: newValue, weight: .regular)
        }
    }
    
    var spacing: CGFloat {
        get {
            stackView.spacing
        }
        set {
            stackView.spacing = newValue
        }
    }
    
}
