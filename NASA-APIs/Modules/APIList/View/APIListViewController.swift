import UIKit
import SnapKit

private struct Appearance {
    static let backgroundColor: UIColor = .white
    static let cellTitleFont: UIFont = .init(name: "Apple SD Gothic Neo Bold", size: 13) ?? .systemFont(ofSize: 13)
    static let cellTitleColor: UIColor = .black
}

final class APIListViewController: BaseViewController {

    private let tableIdentifier = "ApiListTableIdentifier"
    
    var presenter: APIListViewOutput!

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableIdentifier)
        tableView.backgroundColor = Appearance.backgroundColor
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        makeConstraints()
        setupBigTitle()
        title = "NASA APIs"
    }

    private func addSubviews() {
        view.addSubview(tableView)
    }

    private func makeConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension APIListViewController: APIListViewInput {
}

extension APIListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getDataSource().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableIdentifier, for: indexPath)
        var configuration = cell.defaultContentConfiguration()
        configuration.textProperties.font = Appearance.cellTitleFont
        configuration.textProperties.color = Appearance.cellTitleColor
        let data = presenter.getDataSource()[indexPath.row]
        configuration.text = data.title
        cell.contentConfiguration = configuration
        return cell
    }
}
