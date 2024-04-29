final class APODsInteractor {
    weak var presenter: APODsInteractorOutput!
    var service: PODsServiceProtocol!

}

extension APODsInteractor: APODsInteractorInput {
    func getPods(with request: PODsServiceRequest) {
        service.getPODs(with: request) { [weak self] result in
            switch result {
            case .success(let response):
                print(response)
                self?.presenter.podsReceivedSuccess(result: response)
            case .failure(let error):
                print(error)
                self?.presenter.podsReceiveFailure()
            }
        }
    }
}
