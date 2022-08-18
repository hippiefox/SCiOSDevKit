//
//  String_Ext.swift
//  KeychainAccess
//
//  Created by PanGu on 2022/8/18.
//

import Foundation
extension String{
    public func sc_jsonString2Dic()-> [String:Any]?{
        guard isEmpty == false,
              let data = data(using: .utf8),
              let dic = try? JSONSerialization.jsonObject(with: data,options: .mutableContainers) as? [String:Any]
        else{
            return nil
        }        
        return dic
    }
}
