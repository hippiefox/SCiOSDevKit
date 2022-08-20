//
//  SCRequestCacheModel.swift
//  SCiOSDevKit
//
//  Created by PanGu on 2022/8/20.
//

import Foundation
import Cache
 
public struct SCReqCacheModel: Codable{
    var data: Data?
}

public class SCRequestCache{
    public static let `default` = SCRequestCache()
    
    private var diskStorage: DiskStorage<String,SCReqCacheModel>?
    
    public init(){
        let bid = SCDevice.bundleId
        let conf = DiskConfig(name: bid)
        let transform = TransformerFactory.forCodable(ofType: SCReqCacheModel.self)
        self.diskStorage = try? DiskStorage<String,SCReqCacheModel>(config: conf, transformer: transform)
    }
    
    public func removeAll(){
        try? self.diskStorage?.removeAll()
    }
    
    public func removeObject(for key: String){
        try? self.diskStorage?.removeObject(forKey: key)
    }
    
    public func object(for key: String)-> SCReqCacheModel?{
        return try? diskStorage?.object(forKey: key)
    }
    
    public func setCache(value: SCReqCacheModel, for key: String){
        DispatchQueue.global().async {
            try? self.diskStorage?.setObject(value, forKey: key, expiry: nil)
        }
    }
}
