//
//  SCBarButtonItem.swift
//  KeychainAccess
//
//  Created by PanGu on 2022/8/18.
//

import UIKit


public class SCBarButtonItem: UIControl{
    public var textFont: UIFont = .systemFont(ofSize: 17){
        didSet{
            titleLabel?.font = textFont
        }
    }
    
    public override var tintColor: UIColor!{
        didSet{
            titleLabel?.textColor = tintColor
            imageView?.tintColor = tintColor
        }
    }
    
    var titleLabel: UILabel?
    var imageView: UIImageView?
    var customView: UIView?
    
    public init(title: String, target: Any?, selector: Selector){
        super.init(frame: .zero)
        addTarget(target, action: selector, for: .touchUpInside)
        titleLabel = UILabel()
        titleLabel?.text = title
        titleLabel?.font = textFont
        titleLabel?.textColor = tintColor
        addSubview(titleLabel!)
    }
    
    public init(image: UIImage?,target: Any?, selector: Selector){
        super.init(frame: .zero)
        addTarget(target, action: selector, for: .touchUpInside)
        imageView = UIImageView()
        imageView?.image = image
        addSubview(imageView!)
    }
    
    public init(customView: UIView){
        super.init(frame: .zero)
        self.customView = customView
        addSubview(customView)
    }
    
    public override var intrinsicContentSize: CGSize {
        if let titleLabel = self.titleLabel {
            titleLabel.sizeToFit()
            return titleLabel.bounds.size
        } else if let imageView = self.imageView {
            imageView.sizeToFit()
            return imageView.bounds.size
        } else if let customView = customView {
            return customView.bounds.size
        } else {
            return .zero
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

