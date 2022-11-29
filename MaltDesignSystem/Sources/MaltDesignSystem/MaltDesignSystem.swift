@_exported import UIKit

public class MaltDesignSystem {
    public static var shared: DesignSystem = DesignSystem()
}

protocol MaltDesignTokenType : AnyObject {
    var colorToken: ColorTokenStyle { get }
    var fontToken: FontTokenStyle { get }
}

