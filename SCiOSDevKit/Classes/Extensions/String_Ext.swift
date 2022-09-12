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
    
    public func sc_apUrlSetQuery(str: String, key: String,value: String)-> String{
        guard let urlComp = URLComponents.init(string: str),
              let q =  urlComp.query,
              var dic = q.sc_jsonString2Dic()
        else{
            return str
        }
        dic[key] = value
        guard let dicStr = dic.sc_convert2JSONString() else{    return str}
        
        let chs = "{}:!@#$^&%*+,\\='\""
        guard let percentCodeStr = dicStr.addingPercentEncoding(withAllowedCharacters: .init(charactersIn: chs).inverted) else{
            return str
        }
        
        var targetUrl = ""
        if let s = urlComp.scheme{
            targetUrl += "\(s)://"
        }
        if let h = urlComp.host{
            targetUrl += "\(h)"
        }
        targetUrl += urlComp.path
        targetUrl += "?"
        targetUrl += percentCodeStr
        
        return targetUrl
    }
}
