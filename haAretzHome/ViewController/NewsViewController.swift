//
//  NewsViewController.swift
//  haAretzHome
//
//  Created by Alexander Livshits on 21/08/2023.
//

import UIKit
import Combine

class NewsViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()

    let viewModel: NewsViewModel
    private var sections: [NewsSectionModel] = []
    var subscriptions = Set<AnyCancellable>()
    
    init(_ viewModel: NewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "NewsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "newsCell")
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        
        subscribeOnPublishers()
        
        viewModel.start()
    }
    
    func subscribeOnPublishers() {
        viewModel.$model.map { $0.main }
            .sink { [weak self] sections in
                self?.sections = sections
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
            }
            .store(in: &subscriptions)
    }
    
    @objc private func refreshNews() {
        viewModel.refreshData()
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "newsCell") as? NewsCell) ?? NewsCell()
        cell.setup(with: sections[indexPath.section].items[indexPath.row])
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let urlString = sections[indexPath.section].items[indexPath.row].link, let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].title
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textAlignment = .right
    }
}
