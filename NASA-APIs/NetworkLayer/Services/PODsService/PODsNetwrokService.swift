

import Foundation

protocol PODsServiceProtocol {
    func getPODs(with request: PODsServiceRequest, completion: @escaping (Result<PODsServiceResponse, Error>) -> Void)
}

final class PODsService: PODsServiceProtocol {
    private struct Route {
        static func podsWith(startDate: String, endDate: String) -> String {
            return "https://api.nasa.gov/planetary/apod?api_key=z7J7Ua78kr2gXYpcE2LjYQCFP3pZJOEaICMYCCEJ&start_date=\(startDate)&end_date=\(endDate)"
        }
    }

    let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    func getPODs(with request: PODsServiceRequest, completion: @escaping (Result<PODsServiceResponse, Error>) -> Void) {
        guard let url = URL(string: Route.podsWith(startDate: request.startDate, endDate: request.endDate)) else { return }
        let urlRequest = URLRequest(url: url)
        networkManager.sendRequest(to: urlRequest, responseT: PODsServiceResponseModel.self) { result in
            switch result {
            case .success(let results):
                completion(.success(.init(response: results)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
