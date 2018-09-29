
import Foundation

struct PhotoViewModel: Equatable, Hashable {
    let id: String
    let latitude: Double
    let longitude: Double
    let title: String
    let thumbnail: URL?
    let fullsize: URL?
}
