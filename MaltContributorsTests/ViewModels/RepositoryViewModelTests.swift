//
//  RepositoryViewModelTests.swift
//  MaltContributorsTests
//
//  Created by Benjamin Sénéchal on 28/10/2022.
//

import Foundation
import Combine
import XCTest
@testable import MaltContributors

class RepositoryViewModelTests: XCTestCase {
    private var cancellables = [AnyCancellable]()
    
    func testViewModelSuccessState() {
        
        let viewModel = RepositoryViewModel(searchService: SearchService(network: Network()))
        viewModel.bind
            .receive(on: DispatchQueue.main)
            .sink { completion in
                
            } receiveValue: { state in
                XCTAssertNotNil(state)
                
                switch state {
                case .success(let contributors):
                    XCTAssertTrue(contributors.count > 0)
                default:
                    return
                }
            }.store(in: &cancellables)
        
        viewModel.fetchRepositories(name: "vuejs", maxRepository: 2, maxUser: 20)
        
    }

    func testViewModelErrorState() {

        let viewModel = RepositoryViewModel(searchService: SearchService(network: Network()))
        viewModel.bind
            .receive(on: DispatchQueue.main)
            .sink { completion in
            
            } receiveValue: { state in
                XCTAssertNotNil(state)

                switch state {
                case .success(let contributors):
                    XCTAssertTrue(contributors.count > 0)
                default:
                    return
                }
            }.store(in: &cancellables)

        viewModel.fetchRepositories(name: "", maxRepository: 2, maxUser: 20)

    }
}
