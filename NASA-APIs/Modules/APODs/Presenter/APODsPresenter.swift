import Foundation
final class APODsPresenter: APODsModuleOutput {
    // MARK: - Output
    var onDatePicker: (() -> Void)?
    var onFinished: (() -> Void)?

    weak var view: APODsViewInput!
    var interactor: APODsInteractorInput!

    private var dataProvider = APODsDataProvider()
    private var dateTypeTapped: APODsDateSelectItemModelType?
    var selectedCustomDates: APODsDatePickerModuleOutputResult?
}

extension APODsPresenter: APODsViewOutput {
    func viewDidLoad() {
        view.setDateSelect()
    }

    func viewDidDeInited() {
        onFinished?()
    }
}

extension APODsPresenter: APODsInteractorOutput {

    func podsReceivedSuccess(result: PODsServiceResponse) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            guard let dateTypeTapped = dateTypeTapped else { return }
            if dateTypeTapped == .custom {
                guard let selectedCustomDates = selectedCustomDates else { return }
                view.selectCustomDate(
                    fromDate: selectedCustomDates.fromDate.simpleFormat(),
                    lastDate: selectedCustomDates.toDate.simpleFormat()
                )
            } else {
                self.selectedCustomDates = nil // remove custom config
                view.selectDate(type: dateTypeTapped)
            }
            self.view.setLoader(state: false)
            self.dataProvider.insertPictureSection(with: result.response)
            self.view.setPictures(section: self.dataProvider.picturesSection)
        }
    }
    
    func podsReceiveFailure() {
        // handle error state
        DispatchQueue.main.async { [weak self] in
            self?.view.setLoader(state: false)
        }
    }
}

// MARK: - APODsCollectionViewManagerDelegate
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
    func sendRequest(type: APODsDateSelectItemModelType) {
        switch type {
        case .today:
            interactor.getPods(with: APODsDateRequestMaker.day.request)
        case .week:
            interactor.getPods(with: APODsDateRequestMaker.week.request)
        case .month:
            interactor.getPods(with: APODsDateRequestMaker.month.request)
        case .year:
            interactor.getPods(with: APODsDateRequestMaker.year.request)
        case .custom:
            guard let selectedCustomDates = selectedCustomDates else { return }
            interactor.getPods(with: APODsDateRequestMaker.custom(selectedCustomDates).request)
        }
    }

    func selectDateTapped(with model: APODsDateSelectItemModel, and indexPath: IndexPath) {
        self.dateTypeTapped = model.type
        if model.type == .custom {
            onDatePicker?()
        } else {
            view.setLoader(state: true)
            sendRequest(type: model.type)
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

extension APODsPresenter: APODsModuleInput {
    func setCustomDates(_ model: APODsDatePickerModuleOutputResult?) {
        guard let model = model else { return }
        self.selectedCustomDates = model
        view.setLoader(state: true)
        sendRequest(type: .custom)
    }
}
