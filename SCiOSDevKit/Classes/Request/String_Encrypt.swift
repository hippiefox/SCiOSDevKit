//
//  String_Encrypt.swift
//  SCiOSDevKit
//
//  Created by PanGu on 2022/8/20.
//

import Foundation


extension String{
    public func aes_256_encryt()-> String?{
        guard let data = self.data(using: .utf8) as NSData? else{   return nil}
        
        let cStr = self.cString(using: .utf8)
        let resultData = NSData.init(bytes: cStr, length: data.length)
        let encrypteStr = (resultData as Data).aes_256_encrypt()
        return encrypteStr
    }
    
    
    public func aes_256_decrypt()-> String?{
        if self.count < 20{ return nil}
        
        let key = (self as NSString).substring(to: 20)
        let content = (self as NSString).substring(from: 20)
        guard let data = Data.init(base64Encoded: content, options: .init(rawValue: 0)) else{return nil}
        
        let result = data.aes_256_decrypt(key)
        return result
    }
}
