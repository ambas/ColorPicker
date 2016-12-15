//
//  ColorPickerButton.swift
//  Pods
//
//  Created by Ambas Chobsanti on 12/17/15.
//
//

import UIKit

open class ColorPickerButton: UIButton {
    
    let roundShape = CAShapeLayer()
    var radius: Double  = 0 {
        didSet {
            roundShape.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: radius*2, height: radius*2)).cgPath
            roundShape.frame = CGRect(x: 0, y: 0, width: radius*2, height: radius*2)
        }
    }
    var color: UIColor = UIColor.black {
        didSet {
            roundShape.fillColor = color.cgColor
        }
    }
    
    public init(frame: CGRect, color: UIColor, radius: Double) {
        super.init(frame: frame)
        configureShape(radius, color: color)
        self.layer.addSublayer(roundShape)
    }
    
    convenience public init(color: UIColor, radius: Double) {
        self.init(frame: CGRect.zero, color: color, radius: radius)
    }
    
    convenience public init(color: UIColor) {
        self.init(frame: CGRect.zero, color: color, radius: ButtonCofiguration.pickerButtonRadius)
    }
    
    convenience public init(colorHex: String) {
       self.init(frame: CGRect.zero, color: UIColor.colorWithHexString(colorHex) ?? .black, radius: ButtonCofiguration.pickerButtonRadius)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureShape(radius, color: color)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        roundShape.fillColor = color.cgColor
        roundShape.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: radius*2, height: radius*2)).cgPath
        roundShape.bounds.size = CGSize(width: radius*2, height: radius*2)
        let center = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        roundShape.position = center
    }
    
    fileprivate func configureShape(_ radius: Double, color: UIColor) {
        self.radius = radius
        self.color = color
    }
    
    func pickerColor() -> String {
        let shapeColor = roundShape.fillColor ?? UIColor.black.cgColor
        return UIColor(cgColor: shapeColor).hexString()
    }
}
