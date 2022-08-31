//
//  SCRefreshProtocol.swift
//  Alamofire
//
//  Created by PanGu on 2022/8/29.
//

import Foundation
import MJRefresh

public protocol SCRefreshProtocol: UIViewController{
    var refreshScrollView: UIScrollView!{get}
    func requestData(_ isRefreshing: Bool)
    func addRefresh()
    func addLoadMore()
    func endRefresh()
}

public extension SCRefreshProtocol{
    func addRefresh(){
        refreshScrollView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { [weak self] in
            self?.requestData(true)
        })
    }
    
    func addLoadMore(){
        refreshScrollView.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: { [weak self] in
            self?.requestData(false)
        })
    }
    
    func endRefresh(){
        self.refreshScrollView.mj_footer?.endRefreshing()
        self.refreshScrollView.mj_header?.endRefreshing()
    }
}

open class SCRefreshViewModel{
    open var isRefreshing = true
    open var offset: Int = 0
    
    public init(){}
}
