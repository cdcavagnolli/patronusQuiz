import UIKit

class ButtonView: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        titleLabel?.textColor = .clear
        setBackgroundImage(UIImage(named: Constants.buttonBackgound), for: .normal)
    }
}
