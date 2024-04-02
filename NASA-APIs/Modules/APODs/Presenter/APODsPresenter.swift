final class APODsPresenter: APODsModuleOutput {
    var onFinished: (() -> Void)?
    weak var view: APODsViewInput!
    var interactor: APODsInteractorInput!
}

extension APODsPresenter: APODsViewOutput {
    func viewDidLoad() {
    }

    func viewDidDeInited() {
        onFinished?()
    }
}

extension APODsPresenter: APODsInteractorOutput {

}
