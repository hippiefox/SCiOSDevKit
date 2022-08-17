//
//  SCSize.swift
//  SCiOSDevKit
//
//  Created by PanGu on 2022/8/17.
//

import Foundation
import UIKit

public let SC_SCREEN_WIDTH = UIScreen.main.bounds.width
public let SC_SCREEN_HEIGHT = UIScreen.main.bounds.height

public func SC_Baseline(_ a: CGFloat)-> CGFloat{
    a * SC_SCREEN_WIDTH / 375.0
}

public let SC_SafeAreaInsets = UIApplication.shared.keyWindow!.safeAreaInsets
public let SC_NAV_HEIGHT: CGFloat = SC_SafeAreaInsets.top > 0 ? SC_SafeAreaInsets.top + 44 : SCDevKitConfig.default.nav_height_notX_height
