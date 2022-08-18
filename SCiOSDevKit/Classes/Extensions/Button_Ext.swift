//
//  Button_Ext.swift
//  SCiOSDevKit
//
//  Created by PanGu on 2022/8/18.
//

import Foundation

extension UIButton {
    public func sc_countDown(duration: Int = 60,
                             countingBlock: ((Int) -> Void)? = nil,
                             completion: (() -> Void)? = nil) -> DispatchSourceTimer {
        isEnabled = false
        var _duration = duration
        let ts = DispatchSource.makeTimerSource(flags: .init(rawValue: 0),
                                                queue: DispatchQueue.global())
        ts.schedule(deadline: .now(), repeating: .milliseconds(1000))
        ts.setEventHandler {
            DispatchQueue.main.async {
                _duration -= 1
                if _duration < 0 {
                    ts.cancel()
                    self.isEnabled = true
                    self.setTitle("获取验证码", for: .normal)
                    completion?()
                } else {
                    self.setTitle("\(_duration)s", for: .normal)
                    countingBlock?(_duration)
                }
            }
        }
        ts.activate()
        return ts
    }
}

extension UIButton{
    public convenience init(title: String,textColor: UIColor = .black, font: UIFont = .systemFont(ofSize: 14)){
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(textColor, for: .normal)
        titleLabel?.font = font
    }
}
