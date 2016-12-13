//
//  TestsColorPicker.swift
//  ColorPicker
//
//  Created by Ambas Chobsanti on 12/29/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import ColorPicker

class ColorPickerSpec: QuickSpec {
    override func spec() {
        let colors = [ "#3CAEE2", "#C885D0"]
        var colorPickerListView: ColorPickerListView!
        
        beforeEach { () -> () in
            colorPickerListView = ColorPickerListView(frame: CGRect(x: 0, y: 0, width: 200, height: 44), colors: colors)
        }
        
        describe("test color picker selection") {
            it("should select correct color") {
                colorPickerListView.selectColor(colors[0])
                let selectedButton = colorPickerListView.selectedButton!
                expect(UIColor(cgColor: selectedButton.roundShape.fillColor!).hexString()) == colors[0]
            }
            
            it("should deselect correct color") {
               colorPickerListView.allowsDeselection = true
                colorPickerListView.selectColor(colors[0])
                let selectedButton = colorPickerListView.selectedButton!
                expect(UIColor(cgColor: selectedButton.roundShape.fillColor!).hexString()) == colors[0]
                colorPickerListView.selectColor(colors[0])
                expect(colorPickerListView.selectedButton).to(beNil())
                
            }
            
            it("shoud not deselect when allowDeselect are false") {
                colorPickerListView.allowsDeselection = false
                colorPickerListView.selectColor(colors[0])
                let selectedButton = colorPickerListView.selectedButton!
                expect(UIColor(cgColor: selectedButton.roundShape.fillColor!).hexString()) == colors[0]
                colorPickerListView.selectColor(colors[0])
                expect(UIColor(cgColor: selectedButton.roundShape.fillColor!).hexString()) == colors[0]
            }
            
            it("shoud change color when select other color") {
                colorPickerListView.selectColor(colors[0])
                var selectedButton = colorPickerListView.selectedButton!
                expect(UIColor(cgColor: selectedButton.roundShape.fillColor!).hexString()) == colors[0]
                colorPickerListView.selectColor(colors[1])
                selectedButton = colorPickerListView.selectedButton!
                expect(UIColor(cgColor: selectedButton.roundShape.fillColor!).hexString()) == colors[1]
            }
            
            it("should have correct buttons when changed colors") {
                let newColor = ["#C885D0", "#3CAEE2", "#5EB566", "#FAC16C", "#FA787F", "#A56250"]
                colorPickerListView.colors = newColor
                let button1 = colorPickerListView.colorButtonAt(4)
                expect(UIColor(cgColor: button1.roundShape.fillColor!).hexString()) == newColor[4]
                let button2 = colorPickerListView.colorButtonAt(5)
                expect(UIColor(cgColor: button2.roundShape.fillColor!).hexString()) == newColor[5]
            }
            
            it("should remove selected button when that color are removed") {
                colorPickerListView.selectButtonAtIndex(1)
                let selectedButton = colorPickerListView.selectedButton!
                expect(UIColor(cgColor: selectedButton.roundShape.fillColor!).hexString()) == colors[1]
                let _ = colorPickerListView.colors.popLast()
                expect(colorPickerListView.selectedButton).to(beNil())
            }
            
        }
    }
}
