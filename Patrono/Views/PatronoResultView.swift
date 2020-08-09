import UIKit

class PatronoResultView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel: PatronoResultModel? {
        didSet {
            titleLabel.text = viewModel?.title
            descriptionLabel.text = viewModel?.description
        }
    }
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    private func setupView() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 40, weight: .bold)
        titleLabel.textColor = .white
        addSubview(titleLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = .systemFont(ofSize: 20)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor),
            descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            
            titleLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
    }
}

