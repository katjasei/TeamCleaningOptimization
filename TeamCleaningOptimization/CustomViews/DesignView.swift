//
//  DesignView.swift
//  TeamCleaningOptimization
//
//  Created by iosdev on 30.3.2020.
//  Copyright © 2020 TeamCleaningOptimization. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class DesignView : UIView {
    
    @IBInspectable var cornerRadius : CGFloat = 10
    @IBInspectable var shadowColor : UIColor? = UIColor.black
    
    @IBInspectable let shadowOffSetWidth : Int = 0
    @IBInspectable let shadowOffSetHeight : Int = 3
    
    @IBInspectable let shadowOpacity : Float = 0.5
    
    override func layoutSubviews() {
        
        layer.cornerRadius = cornerRadius
        
        layer.shadowColor = shadowColor?.cgColor
        
        layer.shadowOpacity = shadowOpacity
        
        layer.shadowOffset = CGSize(width: shadowOffSetWidth,height: shadowOffSetHeight)
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.shadowPath = shadowPath.cgPath
        
    }
    
}
