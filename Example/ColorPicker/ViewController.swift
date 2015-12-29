//
//  ViewController.swift
//  ColorPicker
//
//  Created by Ambas on 12/21/2015.
//  Copyright (c) 2015 Ambas. All rights reserved.
//

import UIKit
import ColorPicker

class ViewController: UIViewController, ColorPickerDelegate {

    @IBOutlet weak var colorPicker: ColorPickerListView!
    @IBOutlet weak var alignmentOption: UISegmentedControl!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var allowDeselectSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPicker.colorPickerDelegate = self
    }
    
    @IBAction func didChangeAlignMent(alignmentOption: UISegmentedControl) {
        switch alignmentOption.selectedSegmentIndex {
        case 0:
            colorPicker.alignment = "left"
        case 1:
            colorPicker.alignment = "center"
        case 2:
            colorPicker.alignment = "right"
        default:
           colorPicker.alignment = "left" 
        }
    }
    
    @IBAction func addColor(sender: AnyObject) {
        var colors = colorPicker.colors
        colors.append("#5EB566")
        colorPicker.colors = colors
    }
    
    @IBAction func removeColor(sender: AnyObject) {
        var colors = colorPicker.colors
        colors.popLast()
        colorPicker.colors = colors
    }
    
    func colorPicker(colorPicker: ColorPickerListView, selectedColor: String) {
        colorView.backgroundColor = UIColor.colorWithHexString(selectedColor)
    }
    
    func colorPicker(colorPicker: ColorPickerListView, deselectedColor: String) {
        colorView.backgroundColor = UIColor.whiteColor()
    }
    

    
    @IBAction func changeAllowDeselect(allowDeselectSwitch: UISwitch) {
       colorPicker.allowsDeselection = allowDeselectSwitch.on
    }
}

