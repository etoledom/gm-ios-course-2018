//
//  OfflineNetworkRequest.swift
//  images
//
//  Created by Eduardo Toledo on 9/27/18.
//  Copyright © 2018 GM2018iOS. All rights reserved.
//

import Foundation

struct OfflineNetworkRequest: NetworkRequest {
    func get(url: URL, completion: @escaping (NetworkResponse<Data>) -> Void) {
        let url = Bundle.main.url(forResource: "flickr_photos_response", withExtension: "json")!
        do {
            let data = try Data(contentsOf: url)
            completion(NetworkResponse.success(response: data))
        } catch {
            completion(NetworkResponse.error(error))
        }
    }
}
