//
//  ColorPickerSelection.swift
//  Pods
//
//  Created by Ambas Chobsanti on 12/25/15.
//
//

protocol ColorPickerSelection {
    func colorPicker(colorPicker: ColorPickerListView, changeFromIndex: Int, toIndex: Int)
    func colorPicker(colorPicker: ColorPickerListView, selectedAtIndex: Int)
    func colorPicker(colorPicker: ColorPickerListView, deselectAtIndex: Int)
    func colorPickerPickerLayoutSubviews(colorPicker: ColorPickerListView)
}
