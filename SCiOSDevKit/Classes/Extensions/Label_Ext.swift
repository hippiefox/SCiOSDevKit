//
//  Label_Ext.swift
//  SCiOSDevKit
//
//  Created by PanGu on 2022/8/18.
//

import Foundation

extension UILabel{
    public convenience init(font: UIFont,textColor:UIColor, text: String? = nil){
        self.init()
        self.font = font
        self.textColor = textColor
        self.text = text
    }
    
    public convenience init(fontSize: CGFloat,textColor:UIColor, text: String? = nil){
        self.init(font: .systemFont(ofSize: fontSize), textColor: textColor, text: text)
    }
}
