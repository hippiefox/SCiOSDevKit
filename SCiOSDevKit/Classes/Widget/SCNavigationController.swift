//
//  SCNavigationController.swift
//  SCiOSDevKit
//
//  Created by PanGu on 2022/8/18.
//

import Foundation
import UIKit

public class SCNavigationController: UINavigationController{
    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count >= 1{
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
