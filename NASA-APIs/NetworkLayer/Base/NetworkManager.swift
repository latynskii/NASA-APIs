

import Foundation

protocol NetworkManagerProtocol: AnyObject {
    func sendRequest<T: Decodable>(
        to urlRequest: URLRequest,
        responseT: T.Type,
        completion: @escaping(Result<[T], Error>) -> Void
    )
}


final class NetworkManager: NetworkManagerProtocol {

    func sendRequest<T: Decodable>(
        to urlRequest: URLRequest,
        responseT: T.Type,
        completion: @escaping (Result<[T], any Error>) -> Void) {
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                let jsonDecoder = JSONDecoder()
                do {
                    let result = try jsonDecoder.decode([T].self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
}
