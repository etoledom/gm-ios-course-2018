
import Foundation

struct GoogleBookSearchResult: Decodable {
    let items: [GoogleBookRemote]
}

struct GoogleBookRemote: Decodable {
    let id: String
    let volumeInfo: GoogleBookVolumeInfo
}

struct GoogleBookVolumeInfo: Decodable {
    let title: String
    let subtitle: String?
    let authors: [String]?
    let publisher: String?
    let publishedDate: String?
    let description: String?
    let imageLinks: GoogleBookImageLinks?
}

struct GoogleBookImageLinks: Decodable {
    let smallThumbnail: String
    let thumbnail: String
}
