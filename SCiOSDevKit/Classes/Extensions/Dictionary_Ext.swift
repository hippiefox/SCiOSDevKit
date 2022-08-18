//
//  Dictionary_Ext.swift
//  KeychainAccess
//
//  Created by PanGu on 2022/8/18.
//

import Foundation

extension Dictionary{
    public func sc_convert2JSONString()-> String?{
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []),
              let jsonStr = String(data: data, encoding: .utf8)
        else{   return nil}
        
        return jsonStr
    }
}
