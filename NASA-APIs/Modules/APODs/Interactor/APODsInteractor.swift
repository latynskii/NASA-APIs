final class APODsInteractor {
    weak var presenter: APODsInteractorOutput!
    var service: PODsServiceProtocol!

}

extension APODsInteractor: APODsInteractorInput {
    func getPods(with request: PODsServiceRequest) {
        service.getPODs(with: request) { [weak self] result in
            switch result {
            case .success(let response):
                self?.presenter.podsReceivedSuccess(result: response)
            case .failure:
                self?.presenter.podsReceiveFailure()
            }
        }
    }
}
