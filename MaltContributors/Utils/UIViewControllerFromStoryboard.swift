//
//  UIViewControllerFromStoryboard.swift
//  MaltContributors
//
//  Created by Benjamin Sénéchal on 26/10/2022.
//

import Foundation
import UIKit

public extension UIViewController {
    static func fromStoryboard<T: UIViewController>(storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)) -> T {
        if let viewController =  storyboard.instantiateViewController(withIdentifier: "\(self)") as? T {
            return viewController
        }
        fatalError("instantiateViewControllerWithIdentifier can't find a storyboard identifier called : \(self)")
    }
}
