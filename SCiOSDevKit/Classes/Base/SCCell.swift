//
//  SCCell.swift
//  SCiOSDevKit
//
//  Created by PanGu on 2022/8/17.
//

import Foundation
import UIKit


extension UIView{
    public static var sc_reuseId: String{
        NSStringFromClass(Self.self)
    }
}

public class SC_TableCell<T: UITableViewCell>{
    public static func with(_ tableView: UITableView,
                       indextPath: IndexPath)-> T{
        let cell = tableView.dequeueReusableCell(withIdentifier: T.sc_reuseId, for: indextPath)
        return cell as! T
    }
    
    /// tableView section cell卡片式圆角
    public static func sectionRoundRect(with tableView: UITableView,
                                        at indexPath: IndexPath,
                                        for cell: UITableViewCell,
                                        bgColor: UIColor = .white,
                                        cellRadius: CGFloat = 8)
    {
        let radius: CGFloat = cellRadius
        let layer = CAShapeLayer()
        let rowNum = tableView.numberOfRows(inSection: indexPath.section)
        let bounds = cell.bounds
        var path: UIBezierPath!

        if indexPath.row == 0 && indexPath.row == rowNum - 1 {
            path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: .allCorners,
                                cornerRadii: .init(width: radius, height: radius))
        } else if indexPath.row == 0 {
            path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: .init(rawValue: UIRectCorner.topLeft.rawValue | UIRectCorner.topRight.rawValue),
                                cornerRadii: .init(width: radius, height: radius))
        } else if indexPath.row == rowNum - 1 {
            path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: .init(rawValue: UIRectCorner.bottomLeft.rawValue | UIRectCorner.bottomRight.rawValue),
                                cornerRadii: .init(width: radius, height: radius))
        } else {
            path = UIBezierPath(rect: bounds)
        }

        layer.path = path.cgPath
        layer.fillColor = UIColor.white.cgColor
        let bgView = UIView()
        bgView.layer.insertSublayer(layer, at: 0)
        cell.backgroundView = bgView
    }
}

public class SC_CollectionCell<T: UICollectionViewCell>{
    public static func with(_ collecitonView: UICollectionView,
                       indextPath: IndexPath)-> T{
        let cell = collecitonView.dequeueReusableCell(withReuseIdentifier: T.sc_reuseId, for: indextPath)
        return cell as! T
    }
}

public class SC_CollectionReuse<T: UICollectionReusableView>{
    public static func header(_ collectionView: UICollectionView,
                              indexPath: IndexPath) -> T{
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.sc_reuseId, for: indexPath)
        return header as! T
    }
    
    public static func footer(_ collectionView: UICollectionView,
                              indexPath: IndexPath) -> T{
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter
                                                                     , withReuseIdentifier: T.sc_reuseId, for: indexPath)
        return header as! T
    }
}


