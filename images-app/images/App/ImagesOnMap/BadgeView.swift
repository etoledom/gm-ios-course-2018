import UIKit
import BadgeSwift

class BadgeView: BadgeSwift {
//    let badgeLabel = UILabel()
    var count: Int = 0 {
        didSet {
            self.text = "\(count)"
//            badgeLabel.text = "\(count)"
        }
    }
//
    init() {
        super.init(frame: .zero)
        textColor = .white
        badgeColor = UIColor(red:0.49, green:0.55, blue:0.95, alpha:1.0)
//        super.init(frame: CGRect.zero)
//        configureLabel()
//        widthAnchor.constraint(greaterThanOrEqualTo: heightAnchor, multiplier: 1).isActive = true
    }
//
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        layer.cornerRadius = bounds.height / 2
//    }
//
//    func configureLabel() {
//        badgeLabel.textColor = .white
//        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(badgeLabel)
//        NSLayoutConstraint.activate([
//            badgeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2),
//            badgeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
//            badgeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
//            badgeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 2),
//            ])
//    }
}
