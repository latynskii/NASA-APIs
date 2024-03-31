final class APIListPresenter: APIListModuleOutput {
    var onFinished: (() -> Void)?
    weak var view: APIListViewInput!
    var interactor: APIListInteractorInput!
}

extension APIListPresenter: APIListViewOutput {
    func viewDidLoad() {
    }
}

extension APIListPresenter: APIListInteractorOutput {

}
