//
//  Model.swift
//  MaltContributors
//
//  Created by Benjamin Sénéchal on 28/10/2022.
//

import Foundation

struct User: Decodable {
    let avatarUrl, userUrl, username : String
    let location, name:String?
    let followers: Int

    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url", userUrl = "url", username = "login", name = "name", followers = "followers", location = "location"
    }
}
