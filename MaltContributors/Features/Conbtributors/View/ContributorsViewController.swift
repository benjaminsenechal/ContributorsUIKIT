//
//  ContributorsViewController.swift
//  MaltContributors
//
//  Created by Benjamin Sénéchal on 28/10/2022.
//

import UIKit
import MaltDesignSystem
import Combine

class ContributorsViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet var containerView: HeaderView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.tableFooterView = UIView(frame: CGRect.zero)
            let contributorTableViewCell = UINib(nibName: ContributorTableViewCell.reuseIdentifier, bundle: .main)
            tableView.register(contributorTableViewCell, forCellReuseIdentifier: ContributorTableViewCell.reuseIdentifier)
        }
    }
    
    private var designSystem:DesignSystem?
    private var viewModel:ContributorViewModel?
    private var cancellables = [AnyCancellable]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let header = HeaderViewModel(onBack: onBack)
        if let designSystem = self.designSystem {
            containerView.set(viewModel: header, designSystem: designSystem)
        }

        setStyle()
        updateUI()
        
        viewModel?.bind
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] state in
            switch state {
            case .success:
                self?.tableView.reloadData()
            }
        })
        .store(in: &cancellables)
    }
    
    func updateUI() {
        self.tableView.reloadData()
        self.headerLabel.text = viewModel?.usersLabel
    }
    
    func setStyle() {
        self.headerLabel.textColor = designSystem?.colorToken.title
        self.headerLabel.font = designSystem?.fontToken.subTitleBold
        self.headerView.backgroundColor = designSystem?.colorToken.background
        self.tableView.backgroundColor = designSystem?.colorToken.background
    }
    
    func set(viewModel:ContributorViewModel, designSystem:DesignSystem) {
        self.designSystem = designSystem
        self.viewModel = viewModel
    }
    
    func onBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ContributorsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.users.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContributorTableViewCell") as? ContributorTableViewCell
        guard let cell = cell else { return UITableViewCell() }

        guard let user = self.viewModel?.users[indexPath.row], let designSystem = self.designSystem else { return UITableViewCell() }
        
        cell.set(viewModel: user, designSystem: designSystem)
        return cell
    }
    
    
}
