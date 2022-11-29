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
    static let token = "Bearer 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"
}
