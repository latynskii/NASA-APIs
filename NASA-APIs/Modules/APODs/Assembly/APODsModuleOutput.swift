
protocol APODsModuleOutput: AnyObject {
	var onFinished: (() -> Void)? { get set }
    var onDatePicker: (() -> Void)? { get set }
}

protocol APODsModuleInput: AnyObject {
    func setCustomDates(_ model: APODsDatePickerModuleOutputResult)
}
