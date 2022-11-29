//
//  File.swift
//  
//
//  Created by Benjamin Sénéchal on 27/10/2022.
//

import Foundation

public extension UIButton {
 
    enum Button {
        case primary
        case secondary
        
        public var font : UIFont {
            switch self {
            case .primary, .secondary:
                return FontToken().buttonTitle
            }
        }
        
        public var color : UIColor {
            switch self {
            case .primary, .secondary:
                return ColorToken().primaryButton
            }
        }
        
        public var cornerRadius : Double {
            switch self {
            case .primary:
                return 24
            
            case .secondary:
                return 15.5
            }
        }
    }
    
    func setStyle(buttonStyle:Button) {
        layer.cornerRadius = CGFloat(buttonStyle.cornerRadius)
        titleLabel?.font = buttonStyle.font
        titleLabel?.textColor = .white
        setBackgroundColor(color: buttonStyle.color,  forState: .normal)
    }
}


extension UIButton {
    public  func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}
