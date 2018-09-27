import UIKit

final class DataSource: NSObject, UITableViewDataSource {
    struct Constants {
        static let cellIdentifier = "book_cell"
    }

    var books: [BookViewModel]

    init(books: [BookViewModel]) {
        self.books = books
    }

    func add(_ book: BookViewModel) {
        books.append(book)
    }

    func reset(_ books: [BookViewModel]) {
        self.books = books
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = getBookCell(tableView)
        let book = getBook(at: indexPath)

        cell.textLabel?.text = book.title
        cell.detailTextLabel?.text = book.subtitle
        cell.accessoryType = .disclosureIndicator
        cell.editingAccessoryView = UISwitch()

        return cell
    }

    private func getBookCell(_ tableView: UITableView) -> UITableViewCell {
        let reuseID = Constants.cellIdentifier
        if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: reuseID) {
            return dequeuedCell
        } else {
            return UITableViewCell(style: .subtitle, reuseIdentifier: reuseID)
        }
    }

    func getBook(at: IndexPath) -> BookViewModel {
        return books[at.row]
    }
}
