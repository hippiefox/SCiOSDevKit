//
//  SCBorderRadius.swift
//  SCiOSDevKit
//
//  Created by PanGu on 2022/8/17.
//

import Foundation

public func SC_ViewBorder(_ view: UIView, _ width: CGFloat, _ color: UIColor){
    view.layer.borderColor = color.cgColor
    view.layer.borderWidth = width
}

public func SC_ViewRadius(_ view: UIView, _ radius: CGFloat){
    view.layer.cornerRadius = radius
    view.layer.masksToBounds = true
}

public func SC_ViewBorderRadius(_ view: UIView,_ width: CGFloat, _ color: UIColor, _ radius: CGFloat){
    SC_ViewRadius(view, radius)
    SC_ViewBorder(view, width, color)
}
