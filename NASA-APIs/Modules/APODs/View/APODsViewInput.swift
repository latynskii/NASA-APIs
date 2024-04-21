protocol APODsViewInput: AnyObject {
    func setDateSelect(section: APODsSection)
    func reloadDateSelect(section: APODsSection)
    func customDatesCellTapped(fromValue: String, toValue: String, selected: Bool)
}
