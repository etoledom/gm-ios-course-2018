
import UIKit

class SearchBooksViewController: UIViewController {

    lazy var searchController: UISearchController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let booksController = storyboard.instantiateViewController(withIdentifier: "BooksTableViewController")
        return UISearchController(searchResultsController: booksController)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSearchBar()
        addEmptyView()
        view.backgroundColor = .white
    }

    func addSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search books..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    func addEmptyView() {
        let emptyLabel = UILabel()
        emptyLabel.text = "Search for a book!"

        view.addSubview(emptyLabel)
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}


extension SearchBooksViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
    }
}
