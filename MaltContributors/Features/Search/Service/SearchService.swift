//
//  SearchService.swift
//  MaltContributors
//
//  Created by Benjamin Sénéchal on 26/10/2022.
//

import Foundation
import Combine

protocol SearchServiceType {
    func getRepositories(name:String, maxRepositories:Int) -> AnyPublisher<RepositoryItems, Error>
    func getContributors(url:URL, maxUser:Int) -> AnyPublisher<[Contributors], Error>
    func getUser(url:URL) -> AnyPublisher<User, Error>
}

class SearchService : SearchServiceType {
    
    private let network: Network

    init(network: Network) {
        self.network = network
    }
    
    func getRepositories(name:String, maxRepositories:Int) -> AnyPublisher<RepositoryItems, Error> {
        var request = URLRequest(url: GithubAPI.base.appending(path: "search/repositories").appending(queryItems: [URLQueryItem(name: "q", value: name), URLQueryItem(name: "per_page", value: maxRepositories.description)]))
        request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        request.setValue(GithubAPI.token, forHTTPHeaderField: "Authorization")

        return self.network.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    func getContributors(url:URL, maxUser:Int) -> AnyPublisher<[Contributors], Error> {
        var request = URLRequest(url: url.appending(queryItems: [URLQueryItem(name: "per_page", value: maxUser.description), URLQueryItem(name: "sort", value: "contributors")]))
        request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        request.setValue(GithubAPI.token, forHTTPHeaderField: "Authorization")

        return self.network.runRequests(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    func getUser(url:URL) -> AnyPublisher<User, Error> {
        var request = URLRequest(url: url)
        request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        request.setValue(GithubAPI.token, forHTTPHeaderField: "Authorization")

        return self.network.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
