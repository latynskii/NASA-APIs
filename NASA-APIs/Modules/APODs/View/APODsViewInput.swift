import Foundation

protocol APODsViewInput: AnyObject {
    func setPictures(section: APODsSection)
    func setLoader(state: Bool)
    func selectDate(type: APODsDateSelectItemModelType)
    func selectCustomDate(fromDate: String, lastDate: String)
    func setDateSelect()
}
