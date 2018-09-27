import UIKit

final class SearchResultsViewController: UITableViewController {
    let dataSource = DataSource(books: [])
    weak var delegate: SearchResultsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = dataSource
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBook = dataSource.getBook(at: indexPath)
        delegate?.didSelect(book: selectedBook)
    }
}
