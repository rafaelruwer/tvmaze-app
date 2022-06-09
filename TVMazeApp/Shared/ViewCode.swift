
protocol ViewCode {
    func buildHierarchy()
    func setupConstraints()
    func configureViews()
}

extension ViewCode {
    func configureViews() {
        // no-op
    }
    
    func applyViewCode() {
        buildHierarchy()
        setupConstraints()
        configureViews()
    }
}
