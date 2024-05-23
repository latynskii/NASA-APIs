protocol PodDetailsViewOutput: AnyObject {
    var tableDataSource: [PodDetailsTableDataType] { get }
    func viewDidLoad()
    func backTapped()
}
