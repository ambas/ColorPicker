//
//  ViewController.swift
//  ColorPicker
//
//  Created by Ambas on 12/21/2015.
//  Copyright (c) 2015 Ambas. All rights reserved.
//

import UIKit
import ColorPicker

class ViewController: UIViewController {

    @IBOutlet weak var colorPicker: ColorPickerListView!
    @IBOutlet weak var alignmentOption: UISegmentedControl!
    
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
}

