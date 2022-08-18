//
//  Alert_Ext.swift
//  SCiOSDevKit
//
//  Created by PanGu on 2022/8/18.
//

import Foundation
extension UIAlertController{
    public static func sc_show(from controller: UIViewController,
                        title: String?,
                        message: String?,
                        cancelStr: String?,
                        cancelBlock:(()->Void)?,
                        cancelColor: UIColor? = nil,
                        confirmStr: String,
                        confirmBlock:(()->Void)?,
                        confirmColor: UIColor? = nil)
    {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if cancelStr != nil {
            let cancelAction = UIAlertAction(title: cancelStr!, style: .cancel) { _ in
                cancelBlock?()
            }
            if let cancelColor = cancelColor {
                cancelAction.setValue(cancelColor, forKey: "_titleTextColor")
            }
            ac.addAction(cancelAction)
        }
        
        let confirmAction = UIAlertAction(title: confirmStr, style: .default) { _ in
            confirmBlock?()
        }
        if let confirmColor = confirmColor {
            confirmAction.setValue(confirmColor, forKey: "_titleTextColor")
        }
        ac.addAction(confirmAction)
        controller.present(ac, animated: true, completion: nil)
    }
}
