//
//  ColorPicker.swift
//  Pods
//
//  Created by Ambas Chobsanti on 12/17/15.
//
//

import UIKit

public class ColorPickerListView: UIView {
    
    private lazy var scrollView: UIScrollView = { [unowned self] in
       let scrollView = UIScrollView(frame: self.frame)
        return scrollView
    }()
    
    public lazy var colors: [String] = {
      return ["", "", "", ""]
    }()
    
    public init(frame: CGRect, colors:[String]) {
        super.init(frame: frame)
        self.colors = colors
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}