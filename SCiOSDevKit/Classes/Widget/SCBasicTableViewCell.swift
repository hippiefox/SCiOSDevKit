//
//  SCTableViewCell.swift
//  SCiOSDevKit
//
//  Created by PanGu on 2022/8/17.
//

import UIKit

open class SCBasicTableViewCell: UITableViewCell{
    open lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    open lazy var titleLabel: UILabel = UILabel()
    
    open lazy var accessoryImageView: UIImageView = UIImageView()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configureUI(){
        selectionStyle = .none
        contentView.addSubview(titleLabel)
        contentView.addSubview(iconImageView)
        contentView.addSubview(accessoryImageView)
    }
}
