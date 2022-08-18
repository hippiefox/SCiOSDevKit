//
//  Date_Ext.swift
//  SCiOSDevKit
//
//  Created by PanGu on 2022/8/18.
//

import Foundation

extension Date{
    /// 毫秒数
    public var sc_timeStamp: Int{
        let ti: TimeInterval = self.timeIntervalSince1970
        let millisecond = CLongLong(round(ti * 1000))
        return Int(millisecond)
    }
    
    /// 其中ts为时间戳
    public static func sc_convertTs2DateFormat(_ ts: TimeInterval,format: String = "YYYY-MM-dd HH:mm") -> String{
        let date = Date(timeIntervalSince1970: ts)
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
