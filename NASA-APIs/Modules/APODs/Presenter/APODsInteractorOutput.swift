protocol APODsInteractorOutput: AnyObject {
    func podsReceivedSuccess(result: PODsServiceResponse)
    func podsReceiveFailure()
}
