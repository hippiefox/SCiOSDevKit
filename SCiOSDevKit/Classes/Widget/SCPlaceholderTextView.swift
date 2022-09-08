//
//  SCPlaceholderTextView.swift
//  SCiOSDevKit
//
//  Created by PanGu on 2022/8/17.
//

import UIKit
 
open class SCPlaceholderTextView: UIView{
    /// 0表示不限制
    open var textLimit = 0
    open var textInset: UIEdgeInsets = .zero{
        didSet{
            layoutIfNeeded()
            setNeedsLayout()
        }
    }
    
    open var font: UIFont = .systemFont(ofSize: 15){
        didSet{
            textView.font = font
            placeHolderLabel.font = font
        }
    }
    
    open var textLimitFont: UIFont = .systemFont(ofSize: 12){
        didSet{
            textLimitLabel.font = textLimitFont
        }
    }
    
    open var textColor: UIColor = SC_COLOR(hex: "#333333"){
        didSet{
            textView.textColor = textColor
        }
    }
    
    open var placeholderColor: UIColor = SC_COLOR(hex: "#999999"){
        didSet{
            placeHolderLabel.textColor = placeholderColor
        }
    }
    
    open var textLimitColor: UIColor = SC_COLOR(hex: "#999999"){
        didSet{}
    }
    
    open var text: String?{
        get{    textView.text}
        set{
            textView.text = newValue
            placeHolderLabel.isHidden = textView.hasText
        }
    }
    
    open var placeholderText: String?{
        didSet{
            placeHolderLabel.text = placeholderText
            placeHolderLabel.isHidden = !(placeholderText?.isEmpty == false)
        }
    }
    
    public lazy var textView: UITextView = {
        let view = UITextView()
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.textColor = textColor
        view.font = font
        view.delegate = self
        return view
    }()
    
    private lazy var placeHolderLabel: UILabel = {
        let label = UILabel()
        label.font = font
        label.textColor = placeholderColor
        return label
    }()
    
    private lazy var textLimitLabel: UILabel = {
        let label = UILabel()
        label.font = textLimitFont
        label.textColor = textLimitColor
        return label
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        guard bounds != .zero else{ return}
        
        textView.frame = .init(x: textInset.left,
                               y: textInset.top,
                               width: bounds.width - textInset.left - textInset.right,
                               height: bounds.height - textInset.top - textInset.bottom)
        placeHolderLabel.sizeToFit()
        placeHolderLabel.frame.origin = .init(x: textInset.left + textView.textContainerInset.left + 4, y: textInset.top+textView.textContainerInset.top)
        
    }
}


extension SCPlaceholderTextView{
    private func configureUI(){
        addSubview(textView)
        addSubview(placeHolderLabel)
        placeHolderLabel.isHidden = true
        addSubview(textLimitLabel)
        textLimitLabel.isHidden = true
    }
}

extension SCPlaceholderTextView: UITextViewDelegate{
    open func textViewDidChange(_ textView: UITextView) {
        placeHolderLabel.isHidden = (textView.hasText == true)
        if textLimit > 0{
            var textCount = self.text?.count ?? 0
            if textCount > textLimit{
                textCount = textLimit
                let nowText = textView.text ?? ""
                //截取显示的字符串
                if textCount < nowText.count{
                    let resultText = nowText[nowText.startIndex..<nowText.index(nowText.startIndex, offsetBy: textLimit)]
                    textView.text = String(resultText)
                }
            }
            textLimitLabel.text = "\(textCount)/\(textLimit)"
            textLimitLabel.isHidden = false
            textLimitLabel.sizeToFit()
            textLimitLabel.frame.origin = .init(x: bounds.width - textInset.right - textView.textContainerInset.right - textLimitLabel.frame.width - 4,
                                         y: bounds.height - textInset.bottom - textView.textContainerInset.bottom - textLimitLabel.frame.height)
        }
    }
}
