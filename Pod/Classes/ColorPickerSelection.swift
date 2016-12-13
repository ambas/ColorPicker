//
//  ColorPickerSelection.swift
//  Pods
//
//  Created by Ambas Chobsanti on 12/25/15.
//
//

protocol ColorPickerSelection {
    func colorPicker(_ colorPicker: ColorPickerListView, changeFromIndex: Int, toIndex: Int)
    func colorPicker(_ colorPicker: ColorPickerListView, selectedAtIndex: Int)
    func colorPicker(_ colorPicker: ColorPickerListView, deselectAtIndex: Int)
    func colorPickerPickerLayoutSubviews(_ colorPicker: ColorPickerListView)
}
