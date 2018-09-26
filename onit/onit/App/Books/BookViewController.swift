
import UIKit

class BookViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!

    var book: BookViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initTitle()
        initSubtitle()
        initCover()
        initDescription()
    }

    private func initTitle() {
        titleLabel.text = book?.title
    }

    private func initSubtitle() {
        subtitleLabel.text = book?.subtitle
    }

    private func initCover() {

    }

    private func initDescription() {
        //descriptionTextView.text = book?.
    }
}

