//
//  Int_Ext.swift
//  SCiOSDevKit
//
//  Created by PanGu on 2022/8/18.
//

import Foundation
extension Int{
    /// 描述转换成时间格式
    public func sc_secondsConvertToTimeFormat()-> String{
        let second = self
        let h = second / 3600
        let m = second % 3600 / 60
        let s = second % 60
        let hStr = String(format: "%02d", h)
        let mStr = String(format: "%02d", m)
        let sStr = String(format: "%02d", s)
        if h > 0 { return "\(hStr):\(mStr):\(sStr)" }
        if m > 0 { return "\(mStr):\(sStr)" }
        return "0:\(sStr)"
    }
}
