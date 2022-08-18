//
//  SCEnumResult.swift
//  Pods-SCiOSDevKit_Example
//
//  Created by PanGu on 2022/8/17.
//

import Foundation
public typealias SCValueBlock<Value> = (Value)->Void
public typealias SCNullBlock = ()->Void

public enum SCResult<Value0,Value1>{
    case success(Value0)
    case failure(Value1)
}

public enum SCNullResult{
    case success
    case failure
}

public enum SCValueResult<Value>{
    case success(Value)
    case failure(Value)
}

public enum SCSuccessResult<Value>{
    case success(Value)
    case failure
}

public enum SCErrorResult<Value>{
    case success
    case failure(Value)
}
