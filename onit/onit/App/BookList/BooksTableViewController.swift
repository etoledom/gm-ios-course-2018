
import UIKit

class BooksTableViewController: UITableViewController {
    struct Constants {
        static let cellIdentifier = "book_cell"
        static let segueIdentifier = "show_book"
    }

    var books: [BookViewModel]?

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

        loadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = getBookCell()
        let book = getBook(at: indexPath)

        cell.textLabel?.text = book?.title
        cell.detailTextLabel?.text = book?.subtitle
        cell.accessoryType = .disclosureIndicator
        cell.editingAccessoryView = UISwitch()

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.segueIdentifier, sender: indexPath)
    }

    private func getBookCell() -> UITableViewCell {
        let reuseID = Constants.cellIdentifier
        if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: reuseID) {
            return dequeuedCell
        } else {
            return UITableViewCell(style: .subtitle, reuseIdentifier: reuseID)
        }
    }

    private func getBook(at: IndexPath) -> BookViewModel? {
        return books?[at.row]
    }

    @objc func onAddBookButtonPressed(sender: UIBarButtonItem) {
        let searchBookController = SearchBooksViewController()
        let navigation = UINavigationController(rootViewController: searchBookController)
        present(navigation, animated: true)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueIdentifier,
            let destination = segue.destination as? BookViewController,
            let selectedIndexPath = sender as? IndexPath {
            destination.book = getBook(at: selectedIndexPath)
        }
    }
}

// Added here for convience as I we along,to be extracted
extension BooksTableViewController {
    fileprivate func loadData() {
        let googleBooks = GoogleBooksService(remote: NetworkRequestImpl())
        googleBooks.search(for: "Alice in wonderland") { [weak self ](response) in
            do {
                let googleBooks = try response()
                self?.books = googleBooks.map {
                    return BookViewModel(remote: $0)
                }
                self?.tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
}
