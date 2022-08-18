//
//  Controller_Ext.swift
//  KeychainAccess
//
//  Created by PanGu on 2022/8/18.
//

import Foundation
import UIKit

public func sc_keyWindow() -> UIWindow? {
    if #available(iOS 13, *) {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
           let window = scene.windows.first(where: { $0.isKeyWindow }) {
            return window
        }
    }
    return UIApplication.shared.delegate?.window ?? nil
}

public func sc_visibleViewController()-> UIViewController?{
    guard let win = sc_keyWindow(),
          let root = win.rootViewController
    else {  return nil}
    
    return sc_viewController(from: root)
}

public func sc_viewController(from controller: UIViewController) -> UIViewController {
    if let nav = controller as? UINavigationController,
       let topVC = nav.viewControllers.last
    {
        return sc_viewController(from: topVC)
    }

    if let tab = controller as? UITabBarController,
       let selected = tab.selectedViewController
    {
        return sc_viewController(from: selected)
    }

    if let presentedVC = controller.presentedViewController {
        return sc_viewController(from: presentedVC)
    }

    return controller
}
