
import UIKit

class CreateBookViewController: UIViewController {
    @IBOutlet weak var titleFormField: FormTextView!
    @IBOutlet weak var authorFormField: FormTextView!
    @IBOutlet weak var yearFormField: FormTextView!

    @IBOutlet weak var descriptionTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.text = ""
    }

    @IBAction func onCancelButtonPressed(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true)
    }

    @IBAction func onAddButtonPressed(_ sender: UIButton) {
    }
}
