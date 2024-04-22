import Foundation

protocol APODsViewInput: AnyObject {
    func setDateSelect(section: APODsSection)
    func customDatesCellTapped(fromValue: String, toValue: String, selected: Bool)
    func dateCellTapped(indexPath: IndexPath, selected: Bool)
    func setPictures(section: APODsSection)
}
