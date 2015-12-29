//
//  ColorPicker.swift
//  Pods
//
//  Created by Ambas Chobsanti on 12/17/15.
//
//

import UIKit

public protocol ColorPickerDelegate {
    func colorPicker(colorPicker: ColorPickerListView, selectedColor: String)
    func colorPicker(colorPicker: ColorPickerListView, deselectedColor: String)
}

@IBDesignable

public class ColorPickerListView: UIScrollView {
    
    @IBInspectable public var alignment: String = "left" {
        didSet {
            layoutIfNeeded()
            setNeedsLayout()
        }
    }
    @IBInspectable public var allowsDeselection: Bool = true
    var selectedButton: ColorPickerButton?
    var colorSelectionAnimation = WarpSelectionAnimation()
    public var colorPickerDelegate: ColorPickerDelegate?
    
    private lazy var colorPickerButtons: [ColorPickerButton] = { [unowned self] in
      return self.colors.map(ColorPickerButton.init)
    }()
    
    public var colors = ["#C885D0", "#3CAEE2", "#5EB566", "#FAC16C", "#FA787F", "#A56250"] {
        didSet {
            for button in colorPickerButtons {
                if button == selectedButton {
                    selectedButton = nil
                }
                button.removeFromSuperview()
            }
            colorPickerButtons = colors.map(ColorPickerButton.init)
            configureView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public init(frame: CGRect, colors:[String]) {
        super.init(frame: frame)
        self.colors = colors
        configureView()
    }

    required public init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        configureView()
    }
    
    public override func prepareForInterfaceBuilder() {
       configureView() 
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        for (index, button) in self.colorPickerButtons.enumerate() {
            frame = CGRect(origin: CGPointZero, size: self.bounds.size)
            contentInset = UIEdgeInsetsZero
            let x: CGFloat
            if (alignment.lowercaseString == "left") {
                x = CGRectGetHeight(self.frame) * CGFloat(index)
            } else if(alignment.lowercaseString == "right") {
                let leftPadding = max(CGFloat(CGRectGetWidth(self.frame)) - CGFloat(CGRectGetHeight(self.frame) * CGFloat(colors.count)), 0.0)
                x = (CGRectGetHeight(self.frame) * CGFloat(index)) + leftPadding
            } else {
                let leftPadding = max(CGFloat(CGRectGetWidth(self.frame)) - CGFloat(CGRectGetHeight(self.frame) * CGFloat(colors.count)), 0.0) / 2
                x = CGRectGetHeight(self.frame) * CGFloat(index) + leftPadding
            }
            button.frame = CGRect(x: x, y: 0, width: CGRectGetHeight(self.frame), height: CGRectGetHeight(self.frame))
        }
        contentSize = CGSize(width: CGRectGetHeight(self.frame) * CGFloat(colors.count), height: CGRectGetHeight(self.frame))
        colorSelectionAnimation.colorPickerPickerLayoutSubviews(self)
    }
    
    func colorAt(index: Int) -> String? {
        return  self.colorPickerButtons[index].pickerColor()
    }
    
    func colorButtonAt(index: Int) -> ColorPickerButton {
        return self.colorPickerButtons[index]
    }
    
    private func configureView() {
        self.colorPickerButtons.forEach(self.addSubview)
        for pickerButton in colorPickerButtons {
            self.addSubview(pickerButton)
             pickerButton.addTarget(self, action: "selectColorButton:", forControlEvents: .TouchUpInside)
        }
    }
    
    func selectColor(colorHex: String) {
        guard let indexButton = colors.indexOf(colorHex) else {
           assertionFailure("Wrong Hex color format for \(colorHex)")
           return
        }
        selectButtonAtIndex(indexButton)
    }
    
    func selectButtonAtIndex(index: Int) {
       let button = colorPickerButtons[index]
        selectColorButton(button)
    }
    
    func selectColorButton(colorPickerButton: ColorPickerButton) {
        let colorPickerButtonIndex = colorPickerButtons.indexOf(colorPickerButton)!
        if let selectedButton = self.selectedButton where allowsDeselection && colorPickerButtons.indexOf(selectedButton)! ==  colorPickerButtonIndex {
            self.selectedButton = nil
            colorSelectionAnimation.colorPicker(self, deselectAtIndex: colorPickerButtonIndex)
             colorPickerDelegate?.colorPicker(self, deselectedColor: colors[colorPickerButtonIndex])
        } else if let selectedButton = self.selectedButton where colorPickerButtons.indexOf(selectedButton)! ==  colorPickerButtonIndex {
            // Do noting for this case
        } else if let selectedButton = self.selectedButton where colorPickerButtons.indexOf(selectedButton)! !=  colorPickerButtonIndex {
            colorSelectionAnimation.colorPicker(self, changeFromIndex: colorPickerButtons.indexOf(selectedButton)! , toIndex: colorPickerButtonIndex)
            self.selectedButton = colorPickerButton
            colorPickerDelegate?.colorPicker(self, selectedColor: colors[colorPickerButtonIndex])
        }
        else {
            colorSelectionAnimation.colorPicker(self, selectedAtIndex: colorPickerButtonIndex)
            selectedButton = colorPickerButton
            colorPickerDelegate?.colorPicker(self, selectedColor: colors[colorPickerButtonIndex])
        }
       
    }
}
