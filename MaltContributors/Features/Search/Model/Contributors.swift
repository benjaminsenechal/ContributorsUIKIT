//
//  Contributors.swift
//  MaltContributors
//
//  Created by Benjamin Sénéchal on 27/10/2022.
//

import Foundation

struct Contributors: Decodable {
    let avatarUrl, userUrl : String
    let contributions: Int
    
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url", userUrl = "url" , contributions
    }
}
