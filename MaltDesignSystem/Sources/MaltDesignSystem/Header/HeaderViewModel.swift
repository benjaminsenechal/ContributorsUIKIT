//
//  File.swift
//  
//
//  Created by Benjamin Sénéchal on 28/10/2022.
//

import Foundation


public class HeaderViewModel {
    var onBack:(() -> Void)

    public init(onBack:@escaping (() -> Void)) {
        self.onBack = onBack
    }
}
