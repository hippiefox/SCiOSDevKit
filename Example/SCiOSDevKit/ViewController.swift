//
//  ViewController.swift
//  SCiOSDevKit
//
//  Created by Simon Chow on 08/17/2022.
//  Copyright (c) 2022 Simon Chow. All rights reserved.
/*
 setNeedLayout
 layoutIfNeed 立即更新
 
 
 */

import UIKit
import SnapKit
import SCiOSDevKit

class ViewController: UIViewController {
    
    private lazy var textView: SCPlaceholderTextView = {
        let view = SCPlaceholderTextView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.5)
        view.textInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        view.placeholderText = "请输入"
        view.textLimit = 10
        return view
    }()
    
    private lazy var button: SCFlexibleButton = {
        let btn = SCFlexibleButton()
        btn.maxHeight = 40
        btn.iconNormal = UIImage.init(named: "file_folder")
        btn.iconSize = CGSize(width: 24, height: 24)
        btn.gap = 10
        btn.titleNormal = "新建文件夹"
        btn.titleSelected = "这是一个比较长的名字"
        btn.position = .left
        btn.contentInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        btn.addTarget(self, action: #selector(actionTap(_:)), for: .touchUpInside)
        btn.backgroundColor = .systemPink
        return btn
    }()
    
    @objc private func actionTap(_ sender: UIControl){
        
        sender.isSelected = !sender.isSelected
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(button)
        button.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(100)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

