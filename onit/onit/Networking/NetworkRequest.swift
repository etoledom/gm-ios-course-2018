
import Foundation

enum NetworkResponse<Type> {
    case success(response: Type)
    case error(_ error: Error)
}

protocol NetworkRequest {
    func get(url: URL, completion: @escaping (NetworkResponse<[String: Any]>) -> Void)
}

struct NetworkRequestImpl: NetworkRequest {
    func get(url: URL, completion: @escaping (NetworkResponse<[String: Any]>) -> Void) {

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

            do {
                let object = try JSONSerialization.jsonObject(with: data, options: [])
                if let jsonObject = object as? [String: Any] {
                    let response = NetworkResponse.success(response: jsonObject)
                    completion(response)
                } else {
                    let errorCode = URLError.cannotDecodeContentData
                    let error = NSError(domain: URLError.errorDomain, code: errorCode.rawValue, userInfo: nil)
                    self.returnError(error, to: completion)
                }
            } catch {
                self.returnError(error, to: completion)
            }
        }.resume()
    }

    private func returnError(_ error: Error, to completion: (NetworkResponse<[String: Any]>) -> Void) {
        let errorResponse = NetworkResponse<[String: Any]>.error(error)
        completion(errorResponse)
    }
}
