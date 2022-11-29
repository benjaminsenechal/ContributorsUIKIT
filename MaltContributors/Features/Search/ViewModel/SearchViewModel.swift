//
//  SearchViewModel.swift
//  MaltContributors
//
//  Created by Benjamin Sénéchal on 27/10/2022.
//

import Foundation

class SearchViewModel {
    var onValidate:((_ updatedString:String) -> Void)
    let placeholder, buttonLabel:String
    
    init(placeholder: String, buttonLabel: String, onValidate: @escaping ((_ updatedString:String) -> Void)) {
        self.buttonLabel = buttonLabel
        self.placeholder = placeholder
        self.onValidate = onValidate
    }
}
