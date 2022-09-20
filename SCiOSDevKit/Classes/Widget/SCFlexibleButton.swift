//
//  SCFlexibleButton.swift
//  SCiOSDevKit
//
//  Created by PanGu on 2022/9/1.
/*
    only single-line text is supported
 */

import Foundation

public class SCFlexibleButton: SCButton {
    public var maxHeight: CGFloat = 0
    public var maxWidth: CGFloat = 0
    public var contentInset: UIEdgeInsets = .zero
    
    public override var isSelected: Bool{
        didSet{
            if oldValue != isSelected,
                let _ = self.titleSelected
            {
                invalidateIntrinsicContentSize()
            }
        }
    }
    
    public override var titleNormal: String?{
        didSet{
            if oldValue != nil,
                titleNormal != oldValue
            {
                invalidateIntrinsicContentSize()
            }
        }
    }

    override public var intrinsicContentSize: CGSize {
        
        var text = titleNormal ?? ""
        
        if isSelected && titleSelected != nil{
            text = titleSelected!
        }
        
        var titleSize = CGSize.zero
        if text.isEmpty == false {
            titleSize = (text as NSString).boundingRect(with: .init(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude),
                                                        options: .usesLineFragmentOrigin,
                                                        attributes: [.font: titleFont],
                                                        context: nil).size
            titleSize = .init(width: ceil(titleSize.width), height: ceil(titleSize.height))
        }

        let gap = self.gap
        let iconSize = self.iconSize
        var contentSize: CGSize = .zero

        switch position {
        case .top, .bottom:
            if maxWidth > 0 {
                contentSize = .init(width: maxWidth, height: iconSize.height + gap + titleSize.height)
            } else {
                contentSize = .init(width: max(iconSize.width, titleSize.width), height: iconSize.height + gap + titleSize.height)
            }
            contentSize = .init(width: contentSize.width, height: contentSize.height + contentInset.top + contentInset.bottom)
        case .left, .right:
            if maxHeight > 0 {
                contentSize = .init(width: iconSize.width + gap + titleSize.width, height: maxHeight)
            } else {
                contentSize = .init(width: iconSize.width + gap + titleSize.width, height: max(iconSize.height, titleSize.height))
            }
            contentSize = .init(width: contentSize.width + contentInset.left + contentInset.right, height: contentSize.height)
        }

        return contentSize
    }
}
