//
//  SCFunction.swift
//  SCiOSDevKit
//
//  Created by PanGu on 2022/8/18.
//

import Foundation

public func sc_storage_size_format(_ bytes: Int64,
                                   unit: ByteCountFormatter.Units = .useAll, includeUnit: Bool = true)-> String
{
    if bytes == 0 {
        return includeUnit ? "0b" : "0"
    }
    let format = ByteCountFormatter()
    format.allowedUnits = unit
    format.countStyle = .binary
    format.includesUnit = includeUnit
    return format.string(fromByteCount: Int64(bytes))
}


public protocol SCNotiProtocol{
    var name: String{   get}
}

public func sc_noti(post noti: SCNotiProtocol, userInfo: [AnyHashable: Any]? = nil){
    NotificationCenter.default.post(name: .init(noti.name),
                                    object: nil,
                                    userInfo: userInfo)
}

public func sc_noti(observer: Any,
                     selector: Selector,
                     noti: SCNotiProtocol) {
    NotificationCenter.default.addObserver(observer,
                                           selector: selector,
                                           name: .init(rawValue: noti.name),
                                           object: nil)
}

public func sc_noti(remove observer: Any) {
    NotificationCenter.default.removeObserver(observer)
}

public func SCLog(_ items: Any..., separator: String = " ", terminator: String = "\n"){
    guard SCDevKitConfig.default.isLogEnabled == true else{ return}
    print(items, separator: separator, terminator: terminator)
}
