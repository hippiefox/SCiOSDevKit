//
//  SCAppContext.swift
//  Pods-SCiOSDevKit_Example
//
//  Created by PanGu on 2022/8/17.
//

import Foundation
import KeychainAccess

public enum SCDevice{
    public static let appName: String = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""
    
    public static let bundleId = Bundle.main.bundleIdentifier ?? ""
    
    public static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    
    public static let deviceName = UIDevice.current.name
    
    public static let systemName = UIDevice.current.systemName
    
    public static let systemVersion = UIDevice.current.systemVersion

    public static let deviceModel = UIDevice.current.model

    public static var uniqueID: String{
        let service = SCDevKitConfig.default.deviceIdKey ?? SCDevice.bundleId
        let keyKey = SCDevKitConfig.default.deviceIdKey ?? SCDevice.bundleId
        let kc = Keychain.init(service: service)
        if let id = try? kc.get(keyKey){
            return id
        }
        
        let uuidRef = CFUUIDCreate(kCFAllocatorDefault)
        let uuidString = CFUUIDCreateString(kCFAllocatorDefault, uuidRef) as String? ?? ""
        do {
            try kc.set(uuidString, key: keyKey)
            return uuidString
        } catch {
            return ""
        }
    }
    
    public static let localLanguage = Locale.preferredLanguages[0]
    public static var language: String {
        return Locale.preferredLanguages[0].components(separatedBy: "-").first!
    }

}


