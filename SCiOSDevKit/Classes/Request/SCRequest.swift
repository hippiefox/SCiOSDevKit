//
//  SCRequest.swift
//  SCiOSDevKit
//
//  Created by PanGu on 2022/8/20.
//

import Foundation
import Moya



public struct SCHttpResponse{
    public let data: [AnyHashable:Any]
    public let isCache: Bool
}

public enum SCHttpError{
    case normal
    case networkError
    case parseError
    case decryptError
}


public typealias SCRequestCompletion = (_ result: SCResult<SCHttpResponse,SCHttpError>)->Void
 
public class SCRequest<Target: SCTargetType>{
    public static func request(_ target: Target, completion: @escaping SCRequestCompletion){
        let url = target.baseURL.absoluteString + target.path
        let urlCacheKey = SCRequestCacheKey.keyOf(url: url, params: target.params)
        
        // 读取缓存
        if target.cacheType == .onlyReadCache || target.cacheType == .requestCache{
            if let cachedData = SCRequestCache.default.object(for: urlCacheKey)?.data,
               let json = try? JSONSerialization.jsonObject(with: cachedData,options: []),
               let dic = json as? [AnyHashable:Any]
            {
                let resp = SCHttpResponse.init(data: dic, isCache: true)
                completion(.success(resp))
                if target.cacheType == .onlyReadCache{
                    return
                }
            }
        }
        
        SCRequest.provide(timeout: target.timeoutInterval).request(target) { result in
            switch result{
            case .success(let resp):
                guard let str = try? resp.mapString() else{
                    completion(.failure(.parseError))
                    return
                }
                
                var respStr = str
                //加密的结果
                if target.isRespEncrypted{
                    guard let decryptedStr = str.aes_256_decrypt() else{
                        completion(.failure(.decryptError))
                        return
                    }
                    respStr = decryptedStr
                }
                respStr = respStr.trimmingCharacters(in: .controlCharacters)
                
                guard let jsonData = respStr.data(using: .utf8),
                      let dic = try? JSONSerialization.jsonObject(with: jsonData,options: .fragmentsAllowed) as? [AnyHashable:Any] else{
                    completion(.failure(.parseError))
                    return
                }
                        
                if target.cacheType == .requestCache,
                   let data = try? JSONSerialization.data(withJSONObject: dic, options: .fragmentsAllowed)
                {
                    let cacheModel = SCReqCacheModel.init(data: data)
                    SCRequestCache.default.setCache(value: cacheModel, for: urlCacheKey)
                }
                // parse success without logic judgement
                completion(.success(.init(data: dic, isCache: false)))
            case .failure(let moyaError):
                if moyaError.errorCode == 6{
                    completion(.failure(.networkError))
                }else{
                    completion(.failure(.normal))
                }
            }
        }
    }
}

extension SCRequest{
    private static func provide<Target: SCTargetType>(timeout: TimeInterval)-> MoyaProvider<Target>{
        let requestTimeoutClosure = { (endpoint: Endpoint, done: @escaping MoyaProvider<Target>.RequestResultClosure) in
            do {
                var request = try endpoint.urlRequest()
                request.timeoutInterval = timeout
                done(.success(request))
            } catch {
                done(.failure(MoyaError.underlying(SCError(), nil)))
                return
            }
        }
        let provider = MoyaProvider<Target>(requestClosure: requestTimeoutClosure)
        return provider
    }
}

private struct SCError: Error {}
