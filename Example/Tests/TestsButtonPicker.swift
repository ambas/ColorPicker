//
//  TestsButtonPicker.swift
//  ColorPicker
//
//  Created by Ambas Chobsanti on 12/21/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import ColorPicker

class TableOfContentsSpec: QuickSpec {
    override func spec() {
        let colors = [ "#3CAEE2", "#C885D0"]
        var colorPickerListView: ColorPickerListView!
        
        beforeEach { () -> () in
            colorPickerListView = ColorPickerListView(frame: CGRectZero, colors: colors)
        }
        
        describe("test button appreance") {
            
            it("shoud have same colors") {
                print(colorPickerListView)
                 colorPickerListView = ColorPickerListView(frame: CGRectZero, colors: colors)
                let testColorIndex = 0
                print(colorPickerListView.colorAt(testColorIndex))
                expect(colorPickerListView.colorAt(testColorIndex)!) == colors[testColorIndex]
            }
            
            it("should error for wrong color format") {
                let sampleWrongColor1 = ["1234", "ZZ45F4"]
                colorPickerListView = ColorPickerListView(frame: CGRectZero, colors: sampleWrongColor1)
                let testColorIndex = 0
                expect(colorPickerListView.colorAt(testColorIndex)!) == "#000"
                
                let sampleWrongColor2 = ["#ZZZZZZ", "#ZZZZZZ"]
                colorPickerListView = ColorPickerListView(frame: CGRectZero, colors: sampleWrongColor2)
                expect(colorPickerListView.colorAt(testColorIndex)!) == "#000"
            }
            
            it("shoud return black color when shape no color") {
                let button = colorPickerListView.colorButtonAt(0)
                button.roundShape.fillColor = nil
                expect(button.pickerColor()) == "#000"
            }
            
            it("should have shape inside button"){
                let radius = 10.0
                let sampleRect = CGRect(x: 0, y: 0, width: 44, height: 44)
                let colorPickerButton = ColorPickerButton(frame: sampleRect, color: UIColor.redColor(), radius: radius)
                expect(colorPickerButton.roundShape.frame) == CGRect(x: 0, y: 0, width: 20, height: 20)
            }
            
            it("should have correct position") {
                colorPickerListView = ColorPickerListView(frame: CGRect(x: 0, y: 0, width: 100, height: 44), colors: colors)
                colorPickerListView.layoutIfNeeded()
                let firstButton = colorPickerListView.colorButtonAt(0)
                expect(firstButton.frame) == CGRect(x: 0, y: 0, width: 44, height: 44)
                let secondButton = colorPickerListView.colorButtonAt(1)
                expect(secondButton.frame) == CGRect(x: 44, y: 0, width: 44, height: 44)
            }
            
            it("should have correct button when create button with color and radius") {
                let colorPickerButton = ColorPickerButton(color: UIColor.redColor(), radius: 20)
                expect(UIColor(CGColor: colorPickerButton.roundShape.fillColor!).hexString()) == UIColor.redColor().hexString()
                expect(colorPickerButton.radius) == 20
            }
            
            it("should have correct button when create button with color") {
                let colorPickerButton = ColorPickerButton(color: UIColor.redColor())
                expect(UIColor(CGColor: colorPickerButton.roundShape.fillColor!).hexString()) == UIColor.redColor().hexString()
                expect(colorPickerButton.radius) == ButtonCofiguration.pickerButtonRadius
            }
            
            it("shoud have correct postion when alignment right") {
                colorPickerListView = ColorPickerListView(frame: CGRect(x: 0, y: 0, width: 100, height: 44), colors: colors)
                colorPickerListView.alignment = "right"
                let leftPadding = 100 - (44*2)
               let firstButton = colorPickerListView.colorButtonAt(0)
                let secondButton = colorPickerListView.colorButtonAt(1)
                expect(firstButton.frame) == CGRect(x: leftPadding, y: 0, width: 44, height: 44)
                 expect(secondButton.frame) == CGRect(x: leftPadding + 44, y: 0, width: 44, height: 44)
            }
            
            it("shoud have correct postion when alignment center") {
                colorPickerListView = ColorPickerListView(frame: CGRect(x: 0, y: 0, width: 100, height: 44), colors: colors)
                colorPickerListView.alignment = "center"
                let leftPadding = (100 - (44*2)) / 2
                let firstButton = colorPickerListView.colorButtonAt(0)
                let secondButton = colorPickerListView.colorButtonAt(1)
                expect(firstButton.frame) == CGRect(x: leftPadding, y: 0, width: 44, height: 44)
                expect(secondButton.frame) == CGRect(x: leftPadding + 44, y: 0, width: 44, height: 44)
            }
        }
    }
}
