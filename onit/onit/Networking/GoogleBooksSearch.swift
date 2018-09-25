
import Foundation

struct GoogleBooksSearch {
    let remote: NetworkRequest
    private let searchUrlString = "https://www.googleapis.com/books/v1/volumes?q="

    func search(for bookTitle: String, completion: @escaping (() throws -> [String: Any]) -> Void) {
        let url = searchURL(with: bookTitle)
        remote.get(url: url) { (response) in
            switch response {
            case .success(let response):
                completion { return response }
            case .error(let error):
                completion { throw error }
            }
        }
    }

    private func searchURL(with bookTitle: String) -> URL {
        var components = URLComponents(string: searchUrlString)!
        let searchItem = URLQueryItem(name: "q", value: bookTitle)
        components.queryItems = [searchItem]
        return components.url!
    }
}
