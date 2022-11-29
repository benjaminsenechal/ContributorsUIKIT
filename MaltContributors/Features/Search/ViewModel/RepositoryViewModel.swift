//
//  SearchViewModel.swift
//  MaltContributors
//
//  Created by Benjamin Sénéchal on 26/10/2022.
//

import Foundation
import Combine

protocol ContributorViewModelDelegate: AnyObject {
    func didSelect(users: [UserViewModel], from: RepositoryViewModel)
    func noData(from: RepositoryViewModel)
}

class RepositoryViewModel {
    weak var delegate: ContributorViewModelDelegate?
    
    private let searchService: SearchService
    private var cancellables = [AnyCancellable]()
    let bind: PassthroughSubject<State, Never> = PassthroughSubject()

    enum State {
        case success([UserViewModel])
        case loading
        case error
    }
    
    init(searchService : SearchService) {
        self.searchService = searchService
    }
    
    func fetchRepositories(name:String, maxRepository:Int, maxUser:Int) {
        self.bind.send(State.loading)

        self.searchService.getRepositories(name: name, maxRepositories: maxRepository)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(_):
                    self?.bind.send(State.error)
                case .finished: return
                }
            } receiveValue: { [weak self] repositories in
                self?.getContributors(urls: repositories.items.map({ return $0.contributorsUrl }), maxUser:maxUser)
            }.store(in: &cancellables)
    }
    
    func getContributors(urls : [String], maxUser:Int) {
        let arrayOfPublishers = urls.map { url in
            self.searchService.getContributors(url: URL(string: url)!, maxUser: maxUser)
        }
        
        Publishers.Sequence(sequence: arrayOfPublishers)
            .flatMap { $0 }
            .collect()
            .sink(receiveCompletion: { completion in
                print("")
            }, receiveValue: { [weak self] contributors in
                self?.getUser(contributors: contributors.reduce([], +).map({ return $0 }))
            })
            .store(in: &cancellables)
    }
    
    
    func getUser(contributors: [Contributors]) {
        
        let arrayOfPublishers = contributors.map { contributor in
            self.searchService.getUser(url: URL(string: contributor.userUrl)!)
        }
        
        Publishers.Sequence(sequence: arrayOfPublishers)
            .flatMap { $0 }
            .collect()
            .sink(receiveCompletion: { completion in
                print("")
            }, receiveValue: { [weak self] users in
                let users = users.flatMap { user in
                        contributors.compactMap { c in
                        if c.userUrl.contains(user.userUrl) {
                            return UserViewModel(user: user, contributions: c.contributions)
                        }
                            return nil
                    }
                }
                
                self?.bind.send(State.success(Array(Set(users))))
            })
            .store(in: &cancellables)

    }

    func goToContributors(users:[UserViewModel]) {
        self.delegate?.didSelect(users: users, from: self)
    }
    
    func goToNoData() {
        self.delegate?.noData(from: self)
    }
    
    
}
