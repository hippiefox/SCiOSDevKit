//
//  SCImageTextOption.swift
//  SCiOSDevKit
//
//  Created by PanGu on 2022/9/12.
//

import Foundation
import UIKit

public protocol SCImageTextOption{
    var title: String?{get}
    var icon: UIImage?{get}
    var iconSize: CGSize{get}
    
}

public extension SCImageTextOption{
    var iconSize: CGSize{   return CGSize(width: SC_Baseline(22), height: SC_Baseline(22))}
}
