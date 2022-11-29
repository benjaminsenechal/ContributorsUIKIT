//
//  File.swift
//  
//
//  Created by Benjamin Sénéchal on 21/10/2022.
//

import Foundation

public protocol FontTokenStyle : AnyObject {
    var title: UIFont { get }
    var subTitle: UIFont { get }
    var description: UIFont { get }
    var midTitle: UIFont { get }
    var subTitleBold: UIFont { get }
}


class FontToken : FontTokenStyle {
    var title: UIFont {
        return font(of: 26, fontName: FontName.Moderat.bold.rawValue)
    }
    
    var subTitle: UIFont {
        return font(of: 20, fontName: FontName.Moderat.regular.rawValue)
    }
    
    var midTitle: UIFont {
        return font(of: 17.5, fontName: FontName.Moderat.regular.rawValue)
    }
    
    var buttonTitle: UIFont {
        return font(of: 16, fontName: FontName.Moderat.regular.rawValue)
    }
    
    var subTitleBold: UIFont {
        return font(of: 16, fontName: FontName.Moderat.bold.rawValue)
    }
    
    var description: UIFont {
        return font(of: 12, fontName: FontName.Moderat.regular.rawValue)
    }

    
    private func font(of size: CGFloat, fontName: String) -> UIFont {
        registerFont(fontName: fontName, fontExtension: "woff")
        return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    
    func registerFont(fontName: String, fontExtension: String) {
        guard let fontURL = Bundle.module.url(forResource: fontName, withExtension: fontExtension),
              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider) else {
            fatalError("Couldn't create font from filename: \(fontName) with extension \(fontExtension)")
        }
        var error: Unmanaged<CFError>?
        CTFontManagerRegisterGraphicsFont(font, &error)
    }

}


fileprivate enum FontName {
    fileprivate enum Agrandir: String {
        case tightMedium = "agrandir-tightmedium"
    }
    
    fileprivate enum Moderat: String {
        case bold = "moderat-bold"
        case regular = "moderat-regular"

    }
}

