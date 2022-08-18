//
//  SCCell.swift
//  SCiOSDevKit
//
//  Created by PanGu on 2022/8/17.
//

import Foundation


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


