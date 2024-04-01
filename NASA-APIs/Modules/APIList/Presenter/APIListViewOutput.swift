protocol APIListViewOutput: AnyObject {
    func getDataSource() -> [APIListCellModel]
}
