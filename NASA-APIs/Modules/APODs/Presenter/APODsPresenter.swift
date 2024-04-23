import Foundation
final class APODsPresenter: APODsModuleOutput {
    var onFinished: (() -> Void)?
    weak var view: APODsViewInput!
    var interactor: APODsInteractorInput!

    private var dataProvider = APODsDataProvider()

    private var selectedDateType: APODsDateSelectItemModelType? {
        didSet {
            // TODO: 
        }
    }

    private var previousSelectedCell: IndexPath?

}

extension APODsPresenter: APODsViewOutput {
    func viewDidLoad() {
        view.setDateSelect(section: dataProvider.dateSelectSection)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.view.setPictures(section: self.dataProvider.picturesSection)
        }
    }

    func viewDidDeInited() {
        onFinished?()
    }
}

extension APODsPresenter: APODsInteractorOutput {

}

extension APODsPresenter: APODsCollectionViewManagerDelegate {
    func cellTapped(item: APODsCellItem, indexPath: IndexPath) {
        switch item.type {
        case .dataSelectItemType(type: let model):
            selectDateTapped(with: model, and: indexPath)
        case .imageItemType(type: let model):
           print(model)
        }
    }
}

private extension APODsPresenter {
    func selectDateTapped(with model: APODsDateSelectItemModel, and indexPath: IndexPath) {
        defer {
            self.selectedDateType = model.type
        }
        if model.type == .custom {
            guard self.selectedDateType != .custom else { return }
            // TODO: get real dates
            view.customDatesCellTapped(fromValue: "01.01.01", // select custom date cell
                                       toValue: "01.01.03",
                                       selected: true
            )
            if let previousIndex = previousSelectedCell {
                view.dateCellTapped(indexPath: previousIndex, selected: false) // unselect another dates cells
            }
        } else {
            if selectedDateType == .custom {
                view.customDatesCellTapped(fromValue: "", // unselect custom date cell
                                           toValue: "",
                                           selected: false
                )
            }

            view.dateCellTapped(indexPath: indexPath, selected: true) // select date cell
            if let previousIndex = previousSelectedCell, previousIndex != indexPath {
                view.dateCellTapped(indexPath: previousIndex, selected: false) // unselect another dates cells
            }
            previousSelectedCell = indexPath
        }
    }
}

    // MARK: - BottomBarViewDelegate
extension APODsPresenter {
    func didLeftButtonTapped() {
        onFinished?()
    }
    
    func didRightButtonTapped() {
        // TODO: 
    }
}
