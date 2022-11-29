//
//  ViewController.swift
//  MaltContributors
//
//  Created by Benjamin Sénéchal on 21/10/2022.
//

import UIKit
import MaltDesignSystem
import Combine


class SearchViewController: UIViewController {
    private var cancellables = [AnyCancellable]()
    
    @IBOutlet weak var maxUserView: UIView!
    @IBOutlet weak var maxRepoView: UIView!
    
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var maxUserTextField: UITextField! {
        didSet {
            maxUserTextField.placeholder = String(localized: "welcome_screen_title_user_per_repository")
        }
    }
    @IBOutlet weak var maxRepotextField: UITextField!{
        didSet {
            maxRepotextField.placeholder = String(localized: "welcome_screen_title_max_repository")
            
        }
    }

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchView: SearchView!

    @IBOutlet weak var loadingView: UIView!
    private var designSystem: DesignSystem?
    private var viewModel: RepositoryViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        updateUI()
        
        viewModel?.bind
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] state in
            switch state {
            case .success(let contributors):
                self?.loadingView.isHidden = true
                self?.viewModel?.goToContributors(users:contributors)
                return
            case .loading:
                self?.loadingView.isHidden = false
                return
            case .error:
                self?.loadingView.isHidden = true

                self?.viewModel?.goToNoData()
                return
            }
        })
        .store(in: &cancellables)
    }
    
    func updateUI() {
        self.addSearch()
        self.titleLabel.text = String(localized: "welcome_screen_title")
        self.descriptionLabel.text = String(localized: "welcome_screen_description")
        self.footerView.backgroundColor = designSystem?.colorToken.mainBlue
    }
    
    private func addSearch() {
        guard let designSystem = designSystem else { return }
        searchView?.set(viewModel: SearchViewModel(placeholder: String(localized: "search_view_placeholder"), buttonLabel: String(localized: "search_view_button_title"), onValidate: { [weak self] updatedString in
            if let maxRepo = Int(self?.maxRepotextField.text ?? ""), let maxUser = Int(self?.maxUserTextField.text ?? "") {
                self?.viewModel?.fetchRepositories(name:updatedString, maxRepository: maxRepo, maxUser: maxUser)
            }
            
        }), designSystem: designSystem)
    }
    
    func setStyle() {
        self.loadingView.isHidden = true
        self.descriptionLabel.font = designSystem?.fontToken.subTitle
        self.descriptionLabel.textColor = designSystem?.colorToken.title

        self.titleLabel.textColor = designSystem?.colorToken.title
        self.titleLabel.font = designSystem?.fontToken.title
        
        maxUserView.layer.cornerRadius = 25
        maxUserView.layer.borderWidth = 2.0
        maxUserView.layer.borderColor = designSystem?.colorToken.divider.cgColor
        
        maxRepoView.layer.cornerRadius = 25
        maxRepoView.layer.borderWidth = 2.0
        maxRepoView.layer.borderColor = designSystem?.colorToken.divider.cgColor

        self.maxUserTextField.font = designSystem?.fontToken.description
        self.maxRepotextField.font = designSystem?.fontToken.description

    }
    
    func set(viewModel: RepositoryViewModel, designSystem: DesignSystem) {
        self.viewModel = viewModel
        self.designSystem = designSystem
    }

}

