//
//  SCTableViewCell.swift
//  SCiOSDevKit
//
//  Created by PanGu on 2022/8/17.
//

import UIKit

public class SCBasicTableViewCell: UITableViewCell{
    public lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    public lazy var titleLabel: UILabel = UILabel()
    
    public lazy var accessoryImageView: UIImageView = UIImageView()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureUI(){
        selectionStyle = .none
        contentView.addSubview(titleLabel)
        contentView.addSubview(iconImageView)
        contentView.addSubview(accessoryImageView)
    }
}
