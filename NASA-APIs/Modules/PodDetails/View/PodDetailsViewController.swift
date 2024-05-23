import UIKit

private struct Appearance {
    static let background: UIColor = .lightGray
}

final class PodDetailsViewController: UIViewController {

    var presenter: PodDetailsViewOutput!

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = Appearance.background
        tableView.register(PodDetailImageCell.self, forCellReuseIdentifier: PodDetailImageCell.identifier)
        tableView.register(PodDetailTextCell.self, forCellReuseIdentifier: PodDetailTextCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    private lazy var closeButton: CorneredButtonView = {
        let button = CorneredButtonView(with: UIImage(systemName: "chevron.left"))
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.2
        button.onTap = { [weak self] in
            self?.presenter.backTapped()
        }
        return button
    }()

    private lazy var likeButton: CorneredButtonView = {
        let button = CorneredButtonView(with: UIImage(systemName: "heart"))
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.2
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Appearance.background
        addSubviews()
        makeConstraints()
        presenter.viewDidLoad()
    }

    private func addSubviews() {
        [tableView, closeButton, likeButton].forEach { view.addSubview($0) }
    }

    private func makeConstraints() {
        tableView.snp.makeConstraints {
            let edges: UIEdgeInsets = .init(top: 104, left: 0, bottom: 0, right: 0)
            $0.edges.equalToSuperview().inset(edges)
        }

        closeButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(120)
        }

        likeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(120)
        }
    }
}

extension PodDetailsViewController: PodDetailsViewInput {
    func reloadData() {
        tableView.reloadData()
    }
}


extension PodDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.tableDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        getCell(for: tableView, and: indexPath)
    }
}

extension PodDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = presenter.tableDataSource[indexPath.row]
        switch item {
        case .image:
            return 320
        case .space:
            return 20 // todo if need
        case .text:
            return UITableView.automaticDimension
        }
    }
}

private extension PodDetailsViewController {
    func getCell(for tableView: UITableView, and indexPath: IndexPath) -> UITableViewCell {
        let item = presenter.tableDataSource[indexPath.row]
        let cell: UITableViewCell
        switch item {
        case .image(let data):
            guard let caseCell = tableView.dequeueReusableCell(
                withIdentifier: PodDetailImageCell.identifier, for: indexPath
            ) as? PodDetailImageCell else {
                return UITableViewCell()
            }
            caseCell.setImage(with: data.url)
            cell = caseCell
        case .space:
            let caseCell =  UITableViewCell()
            caseCell.contentView.backgroundColor = .lightGray
            cell = caseCell
        case .text(textData: let textData):
            guard let caseCell = tableView.dequeueReusableCell(
                withIdentifier: PodDetailTextCell.identifier, for: indexPath
            ) as? PodDetailTextCell else {
                return UITableViewCell()
            }
            caseCell.set(title: textData.title, and: textData.subtitle)
            cell = caseCell
        }
        cell.selectionStyle = .none
        return cell
    }
}
