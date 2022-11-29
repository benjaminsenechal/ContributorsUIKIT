//
//  File.swift
//  
//
//  Created by Benjamin Sénéchal on 21/10/2022.
//

import Foundation

public protocol ColorTokenStyle : AnyObject {
    var background: UIColor { get }
    var divider: UIColor { get }
    var border: UIColor { get }
    var primaryButton:UIColor { get }
    var secondaryButton:UIColor { get }
    var title:UIColor { get }
    var description:UIColor { get }
    var mainBlue:UIColor { get }
}

public class ColorToken : ColorTokenStyle {
 
    private enum Colors {
        static let thinRed: UInt32 = 0xFFF4F4
        static let lightRed: UInt32 = 0xFF7370
        static let mainRed: UInt32 = 0xFF5C57
        static let darkRed: UInt32 = 0xD4524F
    
        static let thinBlue: UInt32 = 0xF6F8FF
        static let lightBlue: UInt32 = 0xCDD4FF
        static let mainBlue: UInt32 = 0x0529FC
        static let darkBlue: UInt32 = 0x0833BD
        
        static let thinGray: UInt32 = 0xF7F7F5
        static let lightGray: UInt32 = 0xE0DED9
        static let mainGray: UInt32 = 0x4B4B4B
        static let darkGray: UInt32 = 0x333330
    }
    
    public var mainBlue: UIColor {
        return ColorToken.color(lightHex: Colors.mainBlue, darkHex: Colors.mainBlue)
    }
    
    public var background: UIColor {
        return ColorToken.color(lightHex: Colors.thinBlue, darkHex: Colors.thinBlue)
    }
    
    public var description: UIColor {
        return ColorToken.color(lightHex: Colors.mainGray, darkHex: Colors.mainGray)
    }
    
    public var divider: UIColor {
        return ColorToken.color(lightHex: Colors.lightBlue, darkHex: Colors.lightBlue)
    }
    
    public var border: UIColor {
        return ColorToken.color(lightHex: Colors.lightGray, darkHex: Colors.lightGray)
    }
    
    public var primaryButton: UIColor {
        return ColorToken.color(lightHex: Colors.mainRed, darkHex: Colors.mainRed)
    }
    
    public var secondaryButton : UIColor {
        return ColorToken.color(lightHex: Colors.darkBlue, darkHex: Colors.darkBlue)
    }
    
    public var title: UIColor {
        return ColorToken.color(lightHex: Colors.darkGray, darkHex: Colors.darkGray)
    }

}


private extension ColorToken {
    static func color(lightHex: UInt32, darkHex: UInt32) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                let darkColor = UIColor(hex: darkHex)
                let lightColor = UIColor(hex: lightHex)
                return traitCollection.userInterfaceStyle == .dark ? darkColor : lightColor
            }
        } else {
            // Fallback on earlier versions
            return UIColor(hex: lightHex)
        }
    }
}

private extension UIColor {
    convenience init(hex: UInt32) {
        let divisor = CGFloat(255)
        let red = CGFloat((hex & 0xFF0000) >> 16) / divisor
        let green = CGFloat((hex & 0x00FF00) >> 8) / divisor
        let blue = CGFloat(hex & 0x0000FF) / divisor
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}
