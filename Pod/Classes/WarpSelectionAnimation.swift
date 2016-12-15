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
        view.layer.borderColor = UIColor.colorWithHexString("39B0B8")?.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    var tempRingView: UIView =  {
        let view = UIView()
        view.layer.borderColor = UIColor.colorWithHexString("39B0B8")?.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    func colorPicker(_ colorPicker: ColorPickerListView, changeFromIndex: Int, toIndex: Int) {
        self.colorPicker(colorPicker, deselectedAtIndex: changeFromIndex, ringView: selectedRingView)
        self.colorPicker(colorPicker, selectedAtIndex: toIndex, ringView: tempRingView)
        self.selectedRingView = self.tempRingView
        let delayTime = DispatchTime.now() + Double(Int64(0.4 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            self.selectedRingView = self.tempRingView
            self.tempRingView = UIView()
            self.tempRingView.layer.borderColor = UIColor.colorWithHexString("39B0B8")?.cgColor
            self.tempRingView.layer.borderWidth = 2
        }
    }
    
    func colorPicker(_ colorPicker: ColorPickerListView, selectedAtIndex: Int) {
        self.colorPicker(colorPicker, selectedAtIndex: selectedAtIndex, ringView: selectedRingView)
    }
    
    func colorPicker(_ colorPicker: ColorPickerListView, deselectAtIndex: Int) {
        self.colorPicker(colorPicker, deselectedAtIndex: deselectAtIndex, ringView: selectedRingView)
    }
    
    func colorPickerPickerLayoutSubviews(_ colorPicker: ColorPickerListView) {
        guard let selectedButton = colorPicker.selectedButton else {
            return
        }
        selectedRingView.frame = frameFor(selectedButton.roundShape.frame)
        selectedRingView.center = selectedButton.center
    }
    
    fileprivate func frameFor(_ buttonFrame: CGRect) -> CGRect {
        var ringFrame = buttonFrame
        ringFrame.size.height = ringFrame.size.height + 7
        ringFrame.size.width = ringFrame.size.width + 7
        
        return ringFrame
    }
    
    fileprivate func colorPicker(_ colorPicker: ColorPickerListView, selectedAtIndex: Int, ringView: UIView) {
        colorPicker.isUserInteractionEnabled = false;
        let button = colorPicker.colorButtonAt(selectedAtIndex)
        ringView.frame = frameFor(button.roundShape.frame)
        ringView.center = button.center
        let width = ringView.frame.width
        let height = ringView.frame.height
        ringView.layer.cornerRadius = width < height ? width / 2.0 : height / 2.0;
        colorPicker.insertSubview(ringView, at: 0)
        ringView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseIn, animations: { () -> Void in
            ringView.transform = CGAffineTransform.identity
            }) { (isFinished) -> Void in
                colorPicker.isUserInteractionEnabled = true
        }
    }
    
    fileprivate func colorPicker(_ colorPicker: ColorPickerListView, deselectedAtIndex: Int, ringView: UIView) {
        colorPicker.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseIn, animations: { () -> Void in
            ringView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            }) { (isFinished) -> Void in
                    ringView.removeFromSuperview()
                    ringView.transform = CGAffineTransform.identity
                    colorPicker.isUserInteractionEnabled = true
        }
    }
}
