//
//  ContributorsViewModelTests.swift
//  MaltContributorsTests
//
//  Created by Benjamin Sénéchal on 28/10/2022.
//

import Foundation
import Combine
import XCTest
@testable import MaltContributors

class ContributorsViewModelTests: XCTestCase {
    private var cancellables = [AnyCancellable]()
    
    func testViewModelSuccessState() {
        let viewModel = ContributorViewModel(users: [UserViewModel]())
        viewModel.bind
            .receive(on: DispatchQueue.main)
            .sink { completion in
                
            } receiveValue: { state in
                XCTAssertNotNil(state)
                
                switch state {
                case .success:
                    XCTAssertTrue(viewModel.users.count > 0)
                }
            }.store(in: &cancellables)
    }

}
