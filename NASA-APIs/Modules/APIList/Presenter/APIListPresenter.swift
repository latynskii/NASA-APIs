import Foundation
final class APIListPresenter: APIListModuleOutput {
    var onFinished: (() -> Void)?
    var onOpenAPODs: (() -> Void?)?

    var dataSource: [APIListCellModel] = [
        .init(title: "PODs API", type: .apods),
        .init(title: "Asteroids API", type: .asteroids)
    ]

    weak var view: APIListViewInput!
    var interactor: APIListInteractorInput!
}

extension APIListPresenter: APIListViewOutput {
    func didSelectRow(with index: Int) {
        guard index < dataSource.count else { return }
        let model = dataSource[index]
        switch model.type {

        case .apods:
            onOpenAPODs?()
        case .asteroids:
            break
        }
    }
}

extension APIListPresenter: APIListInteractorOutput {

}
