
import Foundation

enum NetworkResponse<Type> {
    case success(response: Type)
    case error(_ error: Error)
}

protocol NetworkRequest {
    func get(url: URL, completion: @escaping (NetworkResponse<Data>) -> Void)
}

struct NetworkRequestImpl: NetworkRequest {
    func get(url: URL, completion: @escaping (NetworkResponse<Data>) -> Void) {

        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                self.returnError(error, to: completion)
                return
            }

            guard let data = data else {
                let errorCode = URLError.cannotDecodeContentData
                let error = NSError(domain: URLError.errorDomain, code: errorCode.rawValue, userInfo: nil)
                self.returnError(error, to: completion)
                return
            }

            let response = NetworkResponse.success(response: data)
            completion(response)

        }.resume()
    }

    private func returnError(_ error: Error, to completion: (NetworkResponse<Data>) -> Void) {
        let errorResponse = NetworkResponse<Data>.error(error)
        completion(errorResponse)
    }
}
