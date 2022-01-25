//
//  CustomDesign.swift
//  ToDo
//
//  Created by ELAVARASAN K on 23/01/22.
//

import UIKit

@IBDesignable
class CustomCardView: UIView
{

    @IBInspectable var cornerRadius: CGFloat = 2
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var shadowColor: UIColor = UIColor.lightGray
    @IBInspectable var shadowOpacity: Float = 0.5

    override func layoutSubviews()
    {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }

    
}
