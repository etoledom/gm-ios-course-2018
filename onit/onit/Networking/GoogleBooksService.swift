
import Foundation

struct GoogleBooksService {
    let remote: NetworkRequest

    private let searchUrlString = "https://www.googleapis.com/books/v1/volumes"

    func search(for bookTitle: String, completion: @escaping (() throws -> [GoogleBookRemote]) -> Void) {
        guard let url = searchURL(with: bookTitle) else {
            let error = NSError(domain: URLError.errorDomain, code: URLError.badURL.rawValue, userInfo: nil)
            completion { throw error }
            return
        }

        remote.get(url: url) { (response) in
            switch response {
            case .success(let response):
                completion { return try self.googleBooks(from: response) }
            case .error(let error):
                completion { throw error }
            }
        }
    }

    private func searchURL(with bookTitle: String) -> URL? {
        var components = URLComponents(string: searchUrlString)!
        let searchItem = URLQueryItem(name: "q", value: bookTitle)
        components.queryItems = [searchItem]
        return components.url
    }

    private func googleBooks(from data: Data) throws -> [GoogleBookRemote] {
        let bookSearchResult = try JSONDecoder().decode(GoogleBookSearchResult.self, from: data)
        return bookSearchResult.items
    }
}
