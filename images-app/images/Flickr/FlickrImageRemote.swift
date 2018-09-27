
import Foundation

struct FlickrPhotosResponse: Decodable {
    let photos: FlickrPhotosDetail
}

struct FlickrPhotosDetail: Decodable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: String
    let photo: [FlickrPhoto]
}

struct FlickrPhoto: Decodable {
    let id: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let latitude: Double
    let longitude: Double
}

extension FlickrPhoto {

    /// Posible sizes for the image
    ///
    /// - thumb: 100px
    /// - small: 320px
    /// - medium: 640px
    /// - big: 1024px
    /// - original: 1600px
    enum Size: String {
        case thumb = "t"
        case small = "n"
        case medium = "z"
        case big = "b"
        case original = "h"
    }

    /// Return the raw url to download the image with the given size
    ///
    /// - Parameter size: The image size.
    /// - Returns: The image url.
    func photoUrl(size: Size) -> String {
        return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_\(size.rawValue).jpg"
    }
}

struct Photo: Decodable {
    let id: String
    let title: String

    let original: String
    let big: String
    let medium: String
    let small: String
    let thumb: String
}
