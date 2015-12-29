//
//  WarpSelectionAnimation.swift
//  Pods
//
//  Created by Ambas Chobsanti on 12/25/15.
//
//

class WarpSelectionAnimation: ColorPickerSelection {
    
    var selectedRingView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.colorWithHexString("39B0B8").CGColor
        view.layer.borderWidth = 2
        return view
    }()
    
    var tempRingView: UIView =  {
        let view = UIView()
        view.layer.borderColor = UIColor.colorWithHexString("39B0B8").CGColor
        view.layer.borderWidth = 2
        return view
    }()
    
    func colorPicker(colorPicker: ColorPickerListView, changeFromIndex: Int, toIndex: Int) {
        self.colorPicker(colorPicker, deselectedAtIndex: changeFromIndex, ringView: selectedRingView)
        self.colorPicker(colorPicker, selectedAtIndex: toIndex, ringView: tempRingView)
        self.selectedRingView = self.tempRingView
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.4 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.selectedRingView = self.tempRingView
            self.tempRingView = UIView()
            self.tempRingView.layer.borderColor = UIColor.colorWithHexString("39B0B8").CGColor
            self.tempRingView.layer.borderWidth = 2
        }
    }
    
    func colorPicker(colorPicker: ColorPickerListView, selectedAtIndex: Int) {
        self.colorPicker(colorPicker, selectedAtIndex: selectedAtIndex, ringView: selectedRingView)
    }
    
    func colorPicker(colorPicker: ColorPickerListView, deselectAtIndex: Int) {
        self.colorPicker(colorPicker, deselectedAtIndex: deselectAtIndex, ringView: selectedRingView)
    }
    
    func colorPickerPickerLayoutSubviews(colorPicker: ColorPickerListView) {
        guard let selectedButton = colorPicker.selectedButton else {
            return
        }
        selectedRingView.frame = frameFor(selectedButton.roundShape.frame)
        selectedRingView.center = selectedButton.center
    }
    
    private func frameFor(buttonFrame: CGRect) -> CGRect {
        var ringFrame = buttonFrame
        ringFrame.size.height = ringFrame.size.height + 7
        ringFrame.size.width = ringFrame.size.width + 7
        
        return ringFrame
    }
    
    private func colorPicker(colorPicker: ColorPickerListView, selectedAtIndex: Int, ringView: UIView) {
        colorPicker.userInteractionEnabled = false;
        let button = colorPicker.colorButtonAt(selectedAtIndex)
        ringView.frame = frameFor(button.roundShape.frame)
        ringView.center = button.center
        let width = CGRectGetWidth(ringView.frame)
        let height = CGRectGetHeight(ringView.frame)
        ringView.layer.cornerRadius = width < height ? width / 2.0 : height / 2.0;
        colorPicker.insertSubview(ringView, atIndex: 0)
        ringView.transform = CGAffineTransformMakeScale(0.001, 0.001)
        UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .CurveEaseIn, animations: { () -> Void in
            ringView.transform = CGAffineTransformIdentity
            }) { (isFinished) -> Void in
                colorPicker.userInteractionEnabled = true
        }
    }
    
    private func colorPicker(colorPicker: ColorPickerListView, deselectedAtIndex: Int, ringView: UIView) {
        colorPicker.userInteractionEnabled = false
        UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .CurveEaseIn, animations: { () -> Void in
            ringView.transform = CGAffineTransformMakeScale(0.001, 0.001)
            }) { (isFinished) -> Void in
                    ringView.removeFromSuperview()
                    ringView.transform = CGAffineTransformIdentity
                    colorPicker.userInteractionEnabled = true
        }
    }
}
