import UIKit

class LabelView: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .clear
        numberOfLines = 0
        font = .systemFont(ofSize: 18)
        textColor = .white
    }
}
