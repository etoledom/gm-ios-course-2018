//
//  FlickrService.swift
//  images
//
//  Created by Eduardo Toledo on 9/27/18.
//  Copyright © 2018 GM2018iOS. All rights reserved.
//

import Foundation
import CoreLocation

struct FlickrService {
    private let network: NetworkRequest
    private let maximumRadius: CLLocationDistance = 31

    /// Url builder helper.
    ///
    private var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host   = Constants.host
        components.path   = Constants.path

        components.queryItems = [
            URLQueryItem(name: "api_key", value: Credentials.apiKey),
            URLQueryItem(name: "format", value: Constants.format),
            URLQueryItem(name: "nojsoncallback", value: "1")
        ]

        return components
    }

    init(network: NetworkRequest) {
        self.network = network
    }

    func search(in region: CLCircularRegion, completion: @escaping (() throws -> ([FlickrPhoto])) -> Void) {
        guard region.radius < maximumRadius else {
            completion({ return [] })
            return
        }

        let url = getSearchURL(in: region)
        network.get(url: url) { (response) in
            switch response {
            case .success(let data):
                do {
                    let photosResponse = try JSONDecoder().decode(FlickrPhotosResponse.self, from: data)
                    completion { return photosResponse.photos.photo }
                } catch {
                    print("ERROR:")
                    print(error)
                }
            case .error(let error):
                completion { throw error }
            }
        }
    }

    func getSearchURL(in region: CLCircularRegion) -> URL {
        var components = urlComponents
        components.queryItems?.append(Method.search.queryItem)
        components.queryItems?.append(URLQueryItem(name: "lat", value: String(region.center.latitude)))
        components.queryItems?.append(URLQueryItem(name: "lon", value: String(region.center.longitude)))
        components.queryItems?.append(URLQueryItem(name: "radius", value: String(region.radius)))
        components.queryItems?.append(URLQueryItem(name: "per_page", value: String(50)))
        components.queryItems?.append(URLQueryItem(name: "extras", value: "geo"))
        return components.url!
    }
}

private enum Credentials {
    static let apiKey = "1ea5baa32f98ac40201da74fed5fc805"
}

private enum Constants {
    static let scheme = "https"
    static let host   = "api.flickr.com"
    static let path   = "/services/rest"
    static let format = "json"
}

private enum Method: String {
    case search   = "flickr.photos.search"

    var queryItem: URLQueryItem {
        return URLQueryItem(name: "method", value: self.rawValue)
    }
}
