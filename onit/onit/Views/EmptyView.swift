
import UIKit

protocol EmptyViewDelegate: class {
    func emptyViewdidPressActionButton(_ emptyView: EmptyView)
}

class EmptyView: UIView {

    private let imageView = UIImageView()
    private let label = UILabel()
    private let button = UIButton(type: .system)
    private let stackView = UIStackView()

    weak var delegate: EmptyViewDelegate?

    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.isHidden = newValue == nil
        }
    }

    var text: String? {
        get {
            return label.text
        }
        set {
            label.text = newValue
            label.isHidden = newValue == nil
        }
    }

    var buttonTitle: String? {
        get {
            return button.title(for: .normal)
        }
        set {
            button.setTitle(newValue, for: .normal)
            button.isHidden = newValue == nil
        }
    }

    init() {
        super.init(frame: .zero)
        addStackView()
        addImageView()
        addLabel()
        addButton()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        stackView.addArrangedSubview(imageView)
    }

    private func addLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        stackView.addArrangedSubview(label)
    }

    private func addButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red:0.80, green:0.56, blue:1.00, alpha:1.0)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(onActionButtonPressed), for: .touchUpInside)
        stackView.addArrangedSubview(button)
    }

    private func addStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12
        
        addSubview(stackView)
        let constraints = [
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    @objc private func onActionButtonPressed() {
        delegate?.emptyViewdidPressActionButton(self)
    }

}
