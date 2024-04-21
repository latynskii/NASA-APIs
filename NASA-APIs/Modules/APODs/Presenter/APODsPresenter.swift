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

}

extension APODsPresenter: APODsViewOutput {
    func viewDidLoad() {
        view.setDateSelect(section: dataProvider.dateSelectSection)
    }

    func viewDidDeInited() {
        onFinished?()
    }
}

extension APODsPresenter: APODsInteractorOutput {

}

extension APODsPresenter: APODsCollectionViewManagerDelegate {
    func cellTapped(section: APODsSection, item: APODsCellItem) {
        switch item.type {
        case .dataSelectItemType(type: let type):
            defer {
                self.selectedDateType = type.type
            }
            if type.type == .custom {
                guard self.selectedDateType != .custom else { return }
                let isSelected = self.selectedDateType == .custom
                // TODO: get real dates
                view.customDatesCellTapped(fromValue: "01.01.01",
                                           toValue: "01.01.03",
                                           selected: true
                )
            } else {
                guard self.selectedDateType == .custom else { return }
                view.customDatesCellTapped(fromValue: "", toValue: "", selected: false)
            }
        }
    }
}
