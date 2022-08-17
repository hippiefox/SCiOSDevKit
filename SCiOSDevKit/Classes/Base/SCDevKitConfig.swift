//
//  SCDevKitConfig.swift
//  SCiOSDevKit
//
//  Created by PanGu on 2022/8/17.
//

import Foundation

public class SCDevKitConfig: NSObject{
    public static let `default` = SCDevKitConfig()
    
    public var nav_bg_color = UIColor.white
    public var nav_bg_alpha: CGFloat = 1
    
    public var nav_title_color: UIColor = .black
    public var nav_title_font = UIFont.systemFont(ofSize: 18)
    /// 左右内容间距
    public var nav_content_hrz_inset: CGFloat = 10
    /// 按钮间距
    public var nav_item_space: CGFloat = 10
    /// 按钮颜色
    public var nav_item_color: UIColor = .black
    public var nav_item_font = UIFont.systemFont(ofSize: 17)
    /// 底部黑线颜色
    public var nav_shadow_line_color = UIColor.lightGray
    
    public var nav_height_notX_height: CGFloat = 64
    
}

