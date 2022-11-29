//
//  NodataViewModel.swift
//  MaltContributors
//
//  Created by Benjamin Sénéchal on 28/10/2022.
//

import Foundation

protocol NodataViewModelViewModelDelegate: AnyObject {
    func goBack(from: NodataViewModel)
}

class NodataViewModel {
    weak var delegate: NodataViewModelViewModelDelegate?

    func goBack() {
        delegate?.goBack(from: self)
    }
}
