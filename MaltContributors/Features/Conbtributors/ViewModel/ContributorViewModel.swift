//
//  ContributorViewModel.swift
//  MaltContributors
//
//  Created by Benjamin Sénéchal on 28/10/2022.
//

import Foundation
import Combine

class ContributorViewModel {
    enum State {
        case success
    }
    
    let bind: PassthroughSubject<State, Never> = PassthroughSubject()
    let users : [UserViewModel]
    
    init(users:[UserViewModel]) {
        
        self.users = users.sorted(by: { vm1, vm2 in
            return vm1.contributions > vm2.contributions
        })
        
        bind.send(State.success)
    }
    
    var usersLabel : String{
        return "\(String(localized: "header_view_label")) \(users.count)"
    }
}
