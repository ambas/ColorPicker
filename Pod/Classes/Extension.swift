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
            return CGFloat(UInt("0", radix: 16)!) / 255
        }
        
        return CGFloat(subString) / 255
    }
    
    public static func colorWithHexString(_ hex: String) -> UIColor? {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if !cString.isValidHexNumber() {
            return nil
        }
        
        if ((cString.characters.count) != 6) {
            return nil
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
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
    
    public func validateHexColorFormat() -> String? {
        if let _ = UIColor.colorWithHexString(self) {
            return self
        } else {
            return nil
        }
    }
    
    fileprivate func isValidHexNumber() -> Bool {
        let chars = NSCharacterSet(charactersIn: "0123456789ABCDEF").inverted
        guard self.uppercased().rangeOfCharacter(from: chars) == nil else {
            return false
        }
        return true
    }
    
}
