//
//  SCColor.swift
//  SCiOSDevKit
//
//  Created by PanGu on 2022/8/17.
//

import Foundation
import UIKit

public func SC_COLOR(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: 1)
}

public func SC_COLORA(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: a)
}

public func SC_COLOR(hex value:String) -> UIColor {
    //strip off prefix
    var startOffset = 0
    
    if value.hasPrefix("#") {startOffset = 1}
    if value.hasPrefix("0x"){startOffset = 2}
    
    let startIndex = value.index(value.startIndex, offsetBy: startOffset)
    let endIndex = value.endIndex
    let hexStr = String(value[startIndex..<endIndex])
    let scanner = Scanner.init(string: hexStr)
    var hexValue:UInt64 = 0
    let isValidHex = scanner.scanHexInt64(&hexValue)
    
    if isValidHex == false{return UIColor.black}
    if hexStr.count != 6 && hexStr.count != 8{return UIColor.black}
    
    var r:CGFloat = 0
    var g:CGFloat = 0
    var b:CGFloat = 0
    var a:CGFloat = 1
    
    if hexStr.count == 6 {
        r = CGFloat((hexValue&0xFF0000)>>16) / 255.0
        g = CGFloat((hexValue&0x00FF00)>>8) / 255.0
        b = CGFloat((hexValue&0xFF)>>0) / 255.0
    }
    
    if hexStr.count == 8 {
        r = CGFloat((hexValue&0xFF000000)>>24) / 255.0
        g = CGFloat((hexValue&0x00FF0000)>>16) / 255.0
        b = CGFloat((hexValue&0xFF00)>>8) / 255.0
        a = CGFloat((hexValue&0xFF)>>0) / 255.0
    }
    
    return UIColor(red: r, green: g, blue: b, alpha: a)
}
