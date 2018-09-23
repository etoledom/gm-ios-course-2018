
struct BookViewModel {
    let title: String
    let subtitle: String
}

let datasource = [
    BookViewModel(title: "\"First Book\"", subtitle: "Author, 2010"),
    BookViewModel(title: "\"Second Book\"", subtitle: "Author, 2010"),
    BookViewModel(title: "\"A long book\"", subtitle: "Author, 2010"),
    BookViewModel(title: "\"No Book\"", subtitle: "Author, 2010")
]

import UIKit

class BooksTableViewController: UITableViewController {

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
        let book = books[indexPath.row]

        cell.textLabel?.text = book.title
        cell.detailTextLabel?.text = book.subtitle
        cell.accessoryType = .disclosureIndicator
        cell.editingAccessoryView = UISwitch()

        return cell
    }

    func getBookCell() -> UITableViewCell {
        let reuseID = "book_cell"
        if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: reuseID) {
            return dequeuedCell
        } else {
            return UITableViewCell(style: .subtitle, reuseIdentifier: reuseID)
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "show_book", sender: indexPath)
    }

    @objc func onAddBookButtonPressed(sender: UIBarButtonItem) {
        let searchBookController = SearchBooksViewController()
        let navigation = UINavigationController(rootViewController: searchBookController)
        present(navigation, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
