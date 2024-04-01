final class APIListPresenter: APIListModuleOutput {
    var onFinished: (() -> Void)?
    weak var view: APIListViewInput!
    var interactor: APIListInteractorInput!
}

extension APIListPresenter: APIListViewOutput {
    func getDataSource() -> [APIListCellModel] {
        [
            .init(title: "PODs API", type: .apods),
            .init(title: "Asteroids API", type: .asteroids)
        ]
    }
}

extension APIListPresenter: APIListInteractorOutput {

}
