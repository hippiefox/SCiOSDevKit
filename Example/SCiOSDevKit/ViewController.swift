//
//  ViewController.swift
//  SCiOSDevKit
//
//  Created by Simon Chow on 08/17/2022.
//  Copyright (c) 2022 Simon Chow. All rights reserved.
//

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
    
    private lazy var button: UIButton = {
        let btn = UIButton()
        btn.setTitle("touch", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(actionTap), for: .touchUpInside)
        return btn
    }()
    
    @objc private func actionTap(){
        let alert = SCBaseAlert.init(position: .bottom)
        alert.hrzPosition = .right
        present(alert, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(button)
        button.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.center.equalToSuperview()
        }
        
        print(SCDevice.language,SCDevice.localLanguage)
        
        
        let target = 300
        let ratio = 0.033
        var balance: Double = 0
        
        for i in 0..<target{
            balance = 100 * pow(1+ratio, Double(i))
            let cur = balance * ratio
            print(i,Int(balance),Int(cur))
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

