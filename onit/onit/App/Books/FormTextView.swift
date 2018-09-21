//
//  FormTextView.swift
//  onit
//
//  Created by Eduardo Toledo on 9/21/18.
//  Copyright © 2018 GM2018iOS. All rights reserved.
//

import UIKit

class FormTextView: UIView {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var inputTextField: UITextField!

    private let nibName = "FormTextView"
    private var contentView: UIView?

    @IBInspectable var title: String {
        get {
            return titleLabel.text ?? ""
        }
        set {
            titleLabel.text = newValue
        }
    }

    @IBInspectable var placeholder: String {
        get {
            return inputTextField.placeholder ?? ""
        }
        set {
            inputTextField.placeholder = newValue
        }
    }

    var inputString: String {
        get {
            return inputTextField.text ?? ""
        }
        set {
            inputTextField.text = newValue
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }

    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
