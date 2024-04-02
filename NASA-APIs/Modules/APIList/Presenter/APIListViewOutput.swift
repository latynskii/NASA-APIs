protocol APIListViewOutput: AnyObject {
    var dataSource: [APIListCellModel] { get }
    func didSelectRow(with index: Int)
}
