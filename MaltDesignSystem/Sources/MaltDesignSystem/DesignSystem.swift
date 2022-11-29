//
//  File.swift
//  
//
//  Created by Benjamin Sénéchal on 21/10/2022.
//

import Foundation

public final class DesignSystem : MaltDesignTokenType {

    private var _colorToken: ColorTokenStyle = ColorToken()
    public var colorToken: ColorTokenStyle {
        return _colorToken
    }

    private var _fontToken: FontTokenStyle = FontToken()
    public var fontToken: FontTokenStyle {
        return _fontToken
    }
    

}
