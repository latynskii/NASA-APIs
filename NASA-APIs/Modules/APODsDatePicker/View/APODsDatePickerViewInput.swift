protocol APODsDatePickerViewInput: AnyObject {
    func set(date: String?, for type: PickDateFieldType)
    func setApplyButton(enabled: Bool)
}
