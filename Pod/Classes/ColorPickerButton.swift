//
//  ColorPickerButton.swift
//  Pods
//
//  Created by Ambas Chobsanti on 12/17/15.
//
//

import UIKit

public class ColorPickerButton: UIButton {
    public init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        defaultConfiguration(self, color: nil)
        self.layer.cornerRadius = cornerRadius(self.frame)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultConfiguration(self, color: nil)
         self.layer.cornerRadius = cornerRadius(self.frame)
    }
    
    public override func layoutSubviews() {
         self.layer.cornerRadius = cornerRadius(self.frame)
    }
    
    func defaultConfiguration(view: UIView, color: UIColor?) {
        view.backgroundColor = color
        view.clipsToBounds = true
    }
    
    func cornerRadius(frame: CGRect) -> CGFloat {
        let width = CGRectGetWidth(frame)
        let height = CGRectGetHeight(frame)
        let radius = width < height ? width / 2.0 : height / 2.0
        return radius
    }
}
