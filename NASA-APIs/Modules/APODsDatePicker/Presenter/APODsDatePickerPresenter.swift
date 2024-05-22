import Foundation

final class APODsDatePickerPresenter: APODsDatePickerModuleOutput {
    var onFinished: ((APODsDatePickerModuleOutputResult?) -> Void)?
    weak var view: APODsDatePickerViewInput!
    var interactor: APODsDatePickerInteractorInput!

    var config: PODsDatePickerConfig?

    private(set) var fromDatePicked: Date?
    private(set) var untilDatePicked: Date?

    private var applyButtonEnabled: Bool {
        fromDatePicked != nil && untilDatePicked != nil
    }
}

extension APODsDatePickerPresenter: APODsDatePickerViewOutput {

    func viewDidLoad() {
        self.fromDatePicked = config?.fromDate
        self.untilDatePicked = config?.untilDate
        view.set(date: config?.fromDate?.simpleFormat(), for: .from)
        view.set(date:  config?.untilDate?.simpleFormat(), for: .until)
        view.setApplyButton(enabled: applyButtonEnabled)
    }

    func viewDidDisappear() {
        closeModule()
    }

    func picked(date: Date?, type: PickDateFieldType) {
        defer {
            view.setApplyButton(enabled: applyButtonEnabled)
        }
        switch type {
        case .from:
            self.fromDatePicked = date
        case .until:
            self.untilDatePicked = date
        }
    }

    func closeTapped() {
        closeModule()
    }

    func applyTapped() {
        closeModule()
    }

    private func closeModule() {
        var result: APODsDatePickerModuleOutputResult?
        if let fromDate = self.fromDatePicked, let untilDate = untilDatePicked {
            result = APODsDatePickerModuleOutputResult(fromDate: fromDate, toDate: untilDate)
        }
        onFinished?(result)
    }
}

extension APODsDatePickerPresenter: APODsDatePickerInteractorOutput {

}
