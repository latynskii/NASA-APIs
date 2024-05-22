import Foundation

protocol APODsDatePickerViewOutput: AnyObject {
    var fromDatePicked: Date? { get }
    var untilDatePicked: Date? { get }
    func viewDidLoad()
    func viewDidDisappear()
    func picked(date: Date?, type: PickDateFieldType)
    func closeTapped()
    func applyTapped()
}
