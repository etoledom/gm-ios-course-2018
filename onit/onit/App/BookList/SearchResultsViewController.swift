import UIKit

final class SearchResultsViewController: UITableViewController {
    let dataSource = DataSource(books: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = dataSource
    }

}
