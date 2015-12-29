//
//  ColorPickerButton.swift
//  Pods
//
//  Created by Ambas Chobsanti on 12/17/15.
//
//

import UIKit

public class ColorPickerButton: UIButton {
    
    let roundShape = CAShapeLayer()
    var radius: Double  = 0 {
        didSet {
            roundShape.path = UIBezierPath(ovalInRect: CGRect(x: 0, y: 0, width: radius*2, height: radius*2)).CGPath
            roundShape.frame = CGRect(x: 0, y: 0, width: radius*2, height: radius*2)
        }
    }
    var color: UIColor = UIColor.blackColor() {
        didSet {
            roundShape.fillColor = color.CGColor
        }
    }
    
    public init(frame: CGRect, color: UIColor, radius: Double) {
        super.init(frame: frame)
        configureShape(radius, color: color)
        self.layer.addSublayer(roundShape)
    }
    
    convenience public init(color: UIColor, radius: Double) {
        self.init(frame: CGRectZero, color: color, radius: radius)
    }
    
    convenience public init(color: UIColor) {
        self.init(frame: CGRectZero, color: color, radius: ButtonCofiguration.pickerButtonRadius)
    }
    
    convenience public init(colorHex: String) {
       self.init(frame: CGRectZero, color: UIColor.colorWithHexString(colorHex), radius: ButtonCofiguration.pickerButtonRadius)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureShape(radius, color: color)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        roundShape.fillColor = color.CGColor
        roundShape.path = UIBezierPath(ovalInRect: CGRect(x: 0, y: 0, width: radius*2, height: radius*2)).CGPath
        roundShape.bounds.size = CGSize(width: radius*2, height: radius*2)
        let center = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        roundShape.position = center
    }
    
    private func configureShape(radius: Double, color: UIColor) {
        self.radius = radius
        self.color = color
    }
    
    func pickerColor() -> String {
        let shapeColor = roundShape.fillColor
        print(shapeColor)
        guard let aShapeColor = shapeColor else {
            return "#000"
        }
        return UIColor(CGColor: aShapeColor).hexString()
    }
}
