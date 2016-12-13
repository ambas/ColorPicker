//
//  Extension.swift
//  Pods
//
//  Created by Ambas Chobsanti on 12/25/15.
//
//

import UIKit

public extension UIColor {
    fileprivate static func component(_ color: String) -> CGFloat {
        guard let subString = UInt(color, radix: 16) else {
            assertionFailure("Wrong Hex color format for \(color)")
            return CGFloat(UInt("0", radix: 16)!) / 255
        }
        
        return CGFloat(subString) / 255
    }
    
    public static func colorWithHexString(_ colorHexString: String) -> UIColor {
        let isIncludeSharp = colorHexString.characters.first == "#"
        let colorHexAfterCondition = isIncludeSharp ? colorHexString.characters.split{$0 == "#"}.map(String.init).last : colorHexString
        guard let _colorHexAfterCondition = colorHexAfterCondition, _colorHexAfterCondition.characters.count == 6 || _colorHexAfterCondition.characters.count == 3 else {
            assertionFailure("Wrong Hex color for \(colorHexAfterCondition)")
            return UIColor.black
        }
        return UIColor(
            red: component(_colorHexAfterCondition.subString(0, to: 1)),
            green: component(_colorHexAfterCondition.subString(2, to: 3)),
            blue: component(_colorHexAfterCondition.subString(4, to: 5)),
            alpha: 1)
    }
    
    public func hexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: nil)
        print("\(r)\(g)\(b)")
        return [r, g, b].map { String(Int($0 * 255), radix:16) }.reduce("#", +).uppercased()
    }
}

extension String {
    func subString(_ from: Int, to: Int) -> String {
        let range = self.characters.index(self.startIndex, offsetBy: from)..<self.characters.index(self.startIndex, offsetBy: to)
        return self.substring(with: range)
    }
}
