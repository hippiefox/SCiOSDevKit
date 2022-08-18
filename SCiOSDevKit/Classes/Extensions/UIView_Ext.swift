//
//  UIView_Ext.swift
//  KeychainAccess
//
//  Created by PanGu on 2022/8/18.
//

import UIKit

extension UIView{
    public func sc_addPadding(_ inset: UIEdgeInsets){
        frame.size.width += (inset.right + inset.left)
        frame.size.height += (inset.top + inset.bottom)
    }
}
