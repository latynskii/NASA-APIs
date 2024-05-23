
import Foundation
final class PodDetailsPresenter: PodDetailsModuleOutput {
    var onFinished: (() -> Void)?
    weak var view: PodDetailsViewInput!
    var interactor: PodDetailsInteractorInput!

    var tableDataSource = [PodDetailsTableDataType]()
    var config: PodDetailsConfig!
}

extension PodDetailsPresenter: PodDetailsViewOutput {
    func viewDidLoad() {
        tableDataSource = [
            .image(imageData: .init(url: config.imageUrl)),
            .space,
            .text(textData: .init(title: config.title, subtitle: config.body))
        ]
        view.reloadData()
    }

    func backTapped() {
        onFinished?()
    }
}

extension PodDetailsPresenter: PodDetailsInteractorOutput {
}
