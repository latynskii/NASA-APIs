
protocol APODsModuleOutput: AnyObject {
	var onFinished: (() -> Void)? { get set }
    var onDatePicker: (() -> Void)? { get set }
}

protocol APODsModuleInput: AnyObject {
    var selectedCustomDates: APODsDatePickerModuleOutputResult? { get }
    func setCustomDates(_ model: APODsDatePickerModuleOutputResult?)
}
