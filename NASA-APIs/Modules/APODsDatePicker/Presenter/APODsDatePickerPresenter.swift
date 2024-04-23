import Foundation

final class APODsDatePickerPresenter: APODsDatePickerModuleOutput {
    var onFinished: ((APODsDatePickerModuleOutputResult) -> Void)?
    weak var view: APODsDatePickerViewInput!
    var interactor: APODsDatePickerInteractorInput!
}

extension APODsDatePickerPresenter: APODsDatePickerViewOutput {

    func viewDidLoad() {

    }

    func viewDidDisappear() {
        let fromDate: Date = .now
        let untilDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: fromDate) ?? Date()
        let mockResult = APODsDatePickerModuleOutputResult(
            fromDate: fromDate,
            toDate: untilDate)
        onFinished?(mockResult)
    }
}

extension APODsDatePickerPresenter: APODsDatePickerInteractorOutput {

}
