
import Foundation

protocol APODsDatePickerModuleOutput {
	var onFinished: ((APODsDatePickerModuleOutputResult) -> Void)? { get set }
}

struct APODsDatePickerModuleOutputResult {
    let fromDate: Date
    let toDate: Date
}
