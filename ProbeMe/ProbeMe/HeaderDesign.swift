//
//  HeaderDesign.swift
//  ProbeMe
//

import UIKit

class HeaderDesign: UIView {
    
    
    override func layoutSubviews() {
            super.layoutSubviews()

            layer.cornerRadius = 24
            layer.maskedCorners = [
                .layerMinXMaxYCorner,
                .layerMaxXMaxYCorner
            ]
            layer.masksToBounds = true
        }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
