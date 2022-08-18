//
//  Array_Ext.swift
//  KeychainAccess
//
//  Created by PanGu on 2022/8/18.
//

import Foundation

extension Array{
    public func sc_convert2JSONString()-> String?{
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: [.fragmentsAllowed,.prettyPrinted]),
              let jsonStr = String.init(data: data, encoding: .utf8)
        else{   return nil}
        
        return jsonStr
    }
}
