

let datasource = [
    BookViewModel(title: "\"Alice in Wonderland\"", subtitle: "Author, 1", thumbnail: "https://books.google.com/books/content?id=iOgx_gklcokC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"),
    BookViewModel(title: "\"Second Book\"", subtitle: "Author, 2", thumbnail: "http://books.google.com/books/content?id=s8dDDwAAQBAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api"),
    BookViewModel(title: "\"A long book\"", subtitle: "Author, 3", thumbnail: "http://books.google.com/books/content?id=s8dDDwAAQBAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api"),
    BookViewModel(title: "\"No Book\"", subtitle: "Author, 4", thumbnail: "http://books.google.com/books/content?id=s8dDDwAAQBAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api")
]

import UIKit

class BooksTableViewController: UITableViewController {
    struct Constants {
        static let cellIdentifier = "book_cell"
        static let segueIdentifier = "show_book"
    }

    let books = datasource

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
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = getBookCell()
        let book = getBook(at: indexPath)

        cell.textLabel?.text = book.title
        cell.detailTextLabel?.text = book.subtitle
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

    private func getBook(at: IndexPath) -> BookViewModel {
        return books[at.row]
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
