//
//  Repository.swift
//  MaltContributors
//
//  Created by Benjamin Sénéchal on 27/10/2022.
//

import Foundation

struct RepositoryItems: Decodable {
    let items : [Repository]
}


struct Repository: Decodable {
    let contributorsUrl : String

    enum CodingKeys: String, CodingKey {
        case contributorsUrl = "contributors_url"
    }
}



