import UIKit

class PatronoStartView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel: PatronoStartModel? {
        didSet {
            label.text = viewModel?.label
            buttonLabel.text = viewModel?.buttonLabel
        }
    }
    
    private let label = LabelView()
    let button = ButtonView()
    private let buttonLabel = LabelView()
    
    private func setupView() {
        backgroundColor = .clear
        
        buttonLabel.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(buttonLabel)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        label.isHidden = true
        
        addSubview(label)
        addSubview(button)
        
        NSLayoutConstraint.activate([
            
            label.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.leftAnchor.constraint(equalTo: leftAnchor),
            label.rightAnchor.constraint(equalTo: rightAnchor),
            
            button.leftAnchor.constraint(equalTo: leftAnchor),
            button.rightAnchor.constraint(equalTo: rightAnchor),
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 75),
            
            buttonLabel.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            buttonLabel.centerXAnchor.constraint(equalTo: button.centerXAnchor)
        ])
    }
}
