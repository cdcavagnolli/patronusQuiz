import UIKit

class ButtonsSetView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel: PatronoAnswersModel? {
        didSet {
            answerOneLabel.text = viewModel?.answerOne
            answerTwoLabel.text = viewModel?.answerTwo
            answerThreeLabel.text = viewModel?.answerThree
            answerOneButton.titleLabel?.text = answerOneLabel.text
            answerTwoButton.titleLabel?.text = answerTwoLabel.text
            answerThreeButton.titleLabel?.text = answerThreeLabel.text
        }
    }
    
    let answerOneButton = ButtonView()
    let answerTwoButton = ButtonView()
    let answerThreeButton = ButtonView()
    
    private let answerOneLabel = LabelView()
    private let answerTwoLabel = LabelView()
    private let answerThreeLabel = LabelView()
    
    private func setupView() {
        backgroundColor = .clear
        answerOneButton.translatesAutoresizingMaskIntoConstraints = false
        answerOneLabel.translatesAutoresizingMaskIntoConstraints = false
        answerOneButton.addSubview(answerOneLabel)
        addSubview(answerOneButton)
        
        answerTwoButton.translatesAutoresizingMaskIntoConstraints = false
        answerTwoLabel.translatesAutoresizingMaskIntoConstraints = false
        answerTwoButton.addSubview(answerTwoLabel)
        addSubview(answerTwoButton)
        
        answerThreeButton.translatesAutoresizingMaskIntoConstraints = false
        answerThreeLabel.translatesAutoresizingMaskIntoConstraints = false
        answerThreeButton.addSubview(answerThreeLabel)
        addSubview(answerThreeButton)
        
        NSLayoutConstraint.activate([
            
            answerOneButton.topAnchor.constraint(equalTo: topAnchor),
            answerOneButton.leftAnchor.constraint(equalTo: leftAnchor),
            answerOneButton.rightAnchor.constraint(equalTo: rightAnchor),
            answerOneButton.heightAnchor.constraint(equalToConstant: 75),
            
            answerTwoButton.topAnchor.constraint(equalTo: answerOneButton.bottomAnchor, constant: 20),
            answerTwoButton.leftAnchor.constraint(equalTo: leftAnchor),
            answerTwoButton.rightAnchor.constraint(equalTo: rightAnchor),
            answerTwoButton.heightAnchor.constraint(equalToConstant: 75),
            
            answerThreeButton.topAnchor.constraint(equalTo: answerTwoButton.bottomAnchor, constant: 20),
            answerThreeButton.leftAnchor.constraint(equalTo: leftAnchor),
            answerThreeButton.rightAnchor.constraint(equalTo: rightAnchor),
            answerThreeButton.heightAnchor.constraint(equalToConstant: 75),
            answerThreeButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            answerOneLabel.centerYAnchor.constraint(equalTo: answerOneButton.centerYAnchor),
            answerOneLabel.centerXAnchor.constraint(equalTo: answerOneButton.centerXAnchor),
            
            answerTwoLabel.centerYAnchor.constraint(equalTo: answerTwoButton.centerYAnchor),
            answerTwoLabel.centerXAnchor.constraint(equalTo: answerTwoButton.centerXAnchor),
            
            answerThreeLabel.centerYAnchor.constraint(equalTo: answerThreeButton.centerYAnchor),
            answerThreeLabel.centerXAnchor.constraint(equalTo: answerThreeButton.centerXAnchor)
        ])
        
    }
}
