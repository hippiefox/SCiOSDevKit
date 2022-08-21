//
//  SCViewController.swift
//  SCiOSDevKit
//
//  Created by PanGu on 2022/8/18.
//

import Foundation
import UIKit

open class SCViewController: UIViewController {
    open var sc_navigationBar: SCNavigationBar?

    open lazy var naviBackButton: SCButton = {
        let button = SCButton()
        button.frame = .init(x: 0, y: 0, width: 30, height: 30)
        button.iconNormal = SCDevKitConfig.default.nav_back_image
        button.iconSize = .init(width: 22, height: 22)
        button.addTarget(self, action: #selector(actionBack), for: .touchUpInside)
        return button
    }()

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        initNavigationBar()
    }

    open func customLeftNavigationItem(_ target: Any?, selector: Selector) -> SCBarButtonItem? {
        var leftItem: SCBarButtonItem?
        if navigationController != nil {
            leftItem = SCBarButtonItem(customView: naviBackButton)
        }
        return leftItem
    }

    @objc private func actionBack() {
        navigationController?.popViewController(animated: true)
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let sc_navigationBar = sc_navigationBar {
            sc_navigationBar.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: SC_NAV_HEIGHT)
            view.bringSubviewToFront(sc_navigationBar)
        }
    }

    private func initNavigationBar() {
        if let navigationController = navigationController {
            sc_navigationBar = SCNavigationBar()
            sc_navigationBar?.weakController = self
            view.addSubview(sc_navigationBar!)
            if navigationController.viewControllers.count > 1 {
                sc_navigationBar?.leftItem = customLeftNavigationItem(self, selector: #selector(actionBack))
            }
        }
    }

    deinit {
        SCLog("------>deinit", self.classForCoder.description())
    }
}
