//
//  MaltAPI.swift
//  MaltContributors
//
//  Created by Benjamin Sénéchal on 27/10/2022.
//

import Foundation

let kBaseURL = "https://api.github.com/"

enum GithubAPI {
    static let base = URL(string: kBaseURL)!
    static let token = Bundle.main.infoDictionary?["TOKEN_GITHUB"] as? String
}
