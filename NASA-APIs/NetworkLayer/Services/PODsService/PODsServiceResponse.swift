
import Foundation

struct PODsServiceResponse: Decodable {
    let response: [PODsServiceResponseModel]
}

struct PODsServiceResponseModel: Decodable {
    let date: String?
    let title: String
    let url: String
    let explanation: String?
}
