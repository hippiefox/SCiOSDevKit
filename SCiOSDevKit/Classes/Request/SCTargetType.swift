//
//  SCTargetType.swift
//  SCiOSDevKit
//
//  Created by PanGu on 2022/8/20.
//

import Foundation
import Moya

public enum SCHUDType{
    case progress
    case progressText(String)
}

public enum SCCacheType{
    case onlyRequest
    case requestCache
    case onlyReadCache
}
 
public protocol SCTargetType: TargetType {
    var cacheType: SCCacheType { get }
    var hudType: SCHUDType{  get}
    var needShowHUD: Bool { get }
    var timeoutInterval: TimeInterval { get }
    var params: [String: Any] { get }
    var isRespEncrypted: Bool{  get}
}
