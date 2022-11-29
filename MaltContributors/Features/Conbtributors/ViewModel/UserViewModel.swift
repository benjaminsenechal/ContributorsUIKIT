//
//  UserViewModel.swift
//  MaltContributors
//
//  Created by Benjamin Sénéchal on 28/10/2022.
//

import Foundation

struct UserViewModel : Hashable{
    
    let avatarUrl, userUrl, username : String
    let location, name:String
    let followers: Int
    let contributions : Int
    
    init(user: User, contributions:Int) {
        avatarUrl = user.avatarUrl
        userUrl = user.userUrl
        location = user.location ?? "No location"
        username = user.username
        name = user.name ?? "No name"
        followers = user.followers
        self.contributions = contributions
    }

    static func == (lhs: UserViewModel, rhs: UserViewModel) -> Bool {
        return lhs.username == rhs.username
    }
}
