
import UIKit

class SearchBooksViewController: UIViewController {
    fileprivate let googleBooks = GoogleBooksService(remote: NetworkRequestImpl())

    lazy var searchController: UISearchController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let booksController = storyboard.instantiateViewController(withIdentifier: "BooksTableViewController")
        return UISearchController(searchResultsController: booksController)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSearchBar()
        addEmptyView()
        addNavBarButtons()
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
        let emptyView = EmptyView()
        emptyView.translatesAutoresizingMaskIntoConstraints = false

        emptyView.text = "Search for a book!"
        emptyView.buttonTitle = "Start searching"
        emptyView.image = #imageLiteral(resourceName: "book-icon")
        emptyView.delegate = self

        view.addSubview(emptyView)
        NSLayoutConstraint.activate([
            emptyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func addNavBarButtons() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDoneButtonPressed))
        navigationItem.rightBarButtonItem = doneButton
    }

    @objc func onDoneButtonPressed() {
        presentingViewController?.dismiss(animated: true)
    }
}


extension SearchBooksViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        if let searchTerm = searchController.searchBar.text {
            googleBooks.search(for: searchTerm) { [weak self ](response) in
                do {
                    let googleBooks = try response()
                    let books = googleBooks.map {
                        return BookViewModel(remote: $0)
                    }
                    if let resultsController = self?.searchController.searchResultsController as? BooksTableViewController {
                        resultsController.dataSource.add(books)
                        resultsController.tableView.reloadData()
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
}

extension SearchBooksViewController: EmptyViewDelegate {
    func emptyViewdidPressActionButton(_ emptyView: EmptyView) {
        searchController.searchBar.becomeFirstResponder()
    }
}
