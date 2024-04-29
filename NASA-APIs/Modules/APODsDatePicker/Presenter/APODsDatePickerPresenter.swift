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
        let untilDate: Date = .now
        let fromDate: Date = Calendar.current.date(byAdding: .weekOfMonth, value: -2, to: untilDate) ?? Date()
        let mockResult = APODsDatePickerModuleOutputResult(
            fromDate: fromDate,
            toDate: untilDate)
        onFinished?(mockResult)
    }
}

extension APODsDatePickerPresenter: APODsDatePickerInteractorOutput {

}
