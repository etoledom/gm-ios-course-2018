
import UIKit

protocol BooksList: class {
    func add(_ content: BookViewModel)
}

final class BooksTableViewController: UITableViewController {
    struct Constants {
        static let segueIdentifier = "show_book"
    }

    let dataSource = DataSource(books: [])

    lazy var addBookButton: UIBarButtonItem = {
        return UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(onAddBookButtonPressed(sender:))
        )
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItems = [addBookButton, editButtonItem]

        tableView.dataSource = dataSource
    }

    @objc func onAddBookButtonPressed(sender: UIBarButtonItem) {
        let searchBookController = SearchBooksViewController()
        searchBookController.list = self
        let navigation = UINavigationController(rootViewController: searchBookController)
        present(navigation, animated: true)
    }

    // MARK: - Navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.segueIdentifier, sender: indexPath)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueIdentifier,
            let destination = segue.destination as? BookViewController,
            let selectedIndexPath = sender as? IndexPath {
            destination.book = dataSource.getBook(at: selectedIndexPath)
        }
    }
}

extension BooksTableViewController: BooksList {
    func add(_ content: BookViewModel) {
        dataSource.add(content)
        tableView.reloadData()
    }
}
