//
//  MainCoordinator.swift
//  MaltContributors
//
//  Created by Benjamin Sénéchal on 24/10/2022.
//

import Foundation
import MaltDesignSystem

class MainCoordinator {
    private let window: UIWindow?
    private let network: Network
    private let designSystem: DesignSystem
    private let navigationController = UINavigationController()

    init(window: UIWindow?, network: Network, designSystem: DesignSystem) {
        self.window = window
        self.network = network
        self.designSystem = designSystem
    }
    
    func start() {
        navigationController.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        showSearchPage()
    }
    
    private func showSearchPage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let searchViewController = SearchViewController.fromStoryboard(storyboard: storyboard) as SearchViewController
        let searchViewModel = RepositoryViewModel(searchService: SearchService(network: network))
        searchViewModel.delegate = self
        searchViewController.set(viewModel: searchViewModel, designSystem: designSystem)
        navigationController.viewControllers = [searchViewController]
    }
    
    
    private func showContributors(users: [UserViewModel]) {
        let storyboard = UIStoryboard(name: "Contributors", bundle: nil)
        let searchViewController = ContributorsViewController.fromStoryboard(storyboard: storyboard) as ContributorsViewController
        let viewModel = ContributorViewModel(users: users)
        searchViewController.set(viewModel:viewModel, designSystem: designSystem)
        navigationController.pushViewController(searchViewController, animated: true)
    }

    private func showNoData() {
        let storyboard = UIStoryboard(name: "Nodata", bundle: nil)
        let noDataViewController = NodataViewController.fromStoryboard(storyboard: storyboard) as NodataViewController
        let viewModel = NodataViewModel()
        viewModel.delegate = self
        noDataViewController.set(viewModel: viewModel, designSystem: self.designSystem)
        navigationController.pushViewController(noDataViewController, animated: true)
    }
}

extension MainCoordinator : ContributorViewModelDelegate {
    func didSelect(users: [UserViewModel], from: RepositoryViewModel) {
        showContributors(users:users)
    }
    
    func noData(from: RepositoryViewModel) {
        showNoData()
    }
}

extension MainCoordinator : NodataViewModelViewModelDelegate {
    func goBack(from: NodataViewModel) {
        self.navigationController.popToRootViewController(animated: true)
    }
    
    
}
