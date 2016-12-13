//
//  ColorPicker.swift
//  Pods
//
//  Created by Ambas Chobsanti on 12/17/15.
//
//

import UIKit

public protocol ColorPickerDelegate {
    func colorPicker(_ colorPicker: ColorPickerListView, selectedColor: String)
    func colorPicker(_ colorPicker: ColorPickerListView, deselectedColor: String)
}

@IBDesignable

open class ColorPickerListView: UIScrollView {
    
    @IBInspectable open var alignment: String = "left" {
        didSet {
            layoutIfNeeded()
            setNeedsLayout()
        }
    }
    @IBInspectable open var allowsDeselection: Bool = true
    var selectedButton: ColorPickerButton?
    var colorSelectionAnimation = WarpSelectionAnimation()
    open var colorPickerDelegate: ColorPickerDelegate?
    
    fileprivate lazy var colorPickerButtons: [ColorPickerButton] = { [unowned self] in
      return self.colors.map(ColorPickerButton.init)
    }()
    
    open var colors = ["#C885D0", "#3CAEE2", "#5EB566", "#FAC16C", "#FA787F", "#A56250"] {
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
    
    open override func prepareForInterfaceBuilder() {
       configureView() 
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        for (index, button) in self.colorPickerButtons.enumerated() {
            frame = CGRect(origin: CGPoint.zero, size: self.bounds.size)
            contentInset = UIEdgeInsets.zero
            let x: CGFloat
            if (alignment.lowercased() == "left") {
                x = self.frame.height * CGFloat(index)
            } else if(alignment.lowercased() == "right") {
                let leftPadding = max(CGFloat(self.frame.width) - CGFloat(self.frame.height * CGFloat(colors.count)), 0.0)
                x = (self.frame.height * CGFloat(index)) + leftPadding
            } else {
                let leftPadding = max(CGFloat(self.frame.width) - CGFloat(self.frame.height * CGFloat(colors.count)), 0.0) / 2
                x = self.frame.height * CGFloat(index) + leftPadding
            }
            button.frame = CGRect(x: x, y: 0, width: self.frame.height, height: self.frame.height)
        }
        contentSize = CGSize(width: self.frame.height * CGFloat(colors.count), height: self.frame.height)
        colorSelectionAnimation.colorPickerPickerLayoutSubviews(self)
    }
    
    func colorAt(_ index: Int) -> String? {
        return  self.colorPickerButtons[index].pickerColor()
    }
    
    func colorButtonAt(_ index: Int) -> ColorPickerButton {
        return self.colorPickerButtons[index]
    }
    
    fileprivate func configureView() {
        self.colorPickerButtons.forEach(self.addSubview)
        for pickerButton in colorPickerButtons {
            self.addSubview(pickerButton)
             pickerButton.addTarget(self, action: #selector(ColorPickerListView.selectColorButton(_:)), for: .touchUpInside)
        }
    }
    
    func selectColor(_ colorHex: String) {
        guard let indexButton = colors.index(of: colorHex) else {
           assertionFailure("Wrong Hex color format for \(colorHex)")
           return
        }
        selectButtonAtIndex(indexButton)
    }
    
    func selectButtonAtIndex(_ index: Int) {
       let button = colorPickerButtons[index]
        selectColorButton(button)
    }
    
    func selectColorButton(_ colorPickerButton: ColorPickerButton) {
        let colorPickerButtonIndex = colorPickerButtons.index(of: colorPickerButton)!
        if let selectedButton = self.selectedButton, allowsDeselection && colorPickerButtons.index(of: selectedButton)! ==  colorPickerButtonIndex {
            self.selectedButton = nil
            colorSelectionAnimation.colorPicker(self, deselectAtIndex: colorPickerButtonIndex)
             colorPickerDelegate?.colorPicker(self, deselectedColor: colors[colorPickerButtonIndex])
        } else if let selectedButton = self.selectedButton, colorPickerButtons.index(of: selectedButton)! ==  colorPickerButtonIndex {
            // Do noting for this case
        } else if let selectedButton = self.selectedButton, colorPickerButtons.index(of: selectedButton)! !=  colorPickerButtonIndex {
            colorSelectionAnimation.colorPicker(self, changeFromIndex: colorPickerButtons.index(of: selectedButton)! , toIndex: colorPickerButtonIndex)
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
