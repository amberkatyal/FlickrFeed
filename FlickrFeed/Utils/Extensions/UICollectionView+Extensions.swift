//
//  UICollectionView+Extensions.swift
//  FlickrFeed
//
//  Created by Amber Katyal on 25/01/21.
//  Copyright © 2021 Amber Katyal. All rights reserved.
//

import UIKit

extension UICollectionView {
    func registerClass<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellWithReuseIdentifier: T.identifier)
    }
    
    func registerNib<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        register(T.nib, forCellWithReuseIdentifier: T.identifier)
    }
    
    func registerClassAndNib<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellWithReuseIdentifier: T.identifier)
        register(T.nib, forCellWithReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.identifier)")
        }
        return cell
    }
}

