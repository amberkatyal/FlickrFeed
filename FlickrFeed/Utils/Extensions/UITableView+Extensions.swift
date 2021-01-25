//
//  UITableView+Extensions.swift
//  FlickrFeed
//
//  Created by Amber Katyal on 17/01/21.
//  Copyright © 2021 Amber Katyal. All rights reserved.
//

import UIKit

extension UITableView {
    
    func setupKeyboardDismissGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        tapGesture.cancelsTouchesInView = false
        addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.endEditing(true)
        }
    }
    
    func registerClass<T: UITableViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellReuseIdentifier: T.identifier)
    }
    
    func registerNib<T: UITableViewCell>(_: T.Type) where T: ReusableView {
        register(T.nib, forCellReuseIdentifier: T.identifier)
    }
    
    func registerClassAndNib<T: UITableViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellReuseIdentifier: T.identifier)
        register(T.nib, forCellReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.identifier)")
        }
        return cell
    }
}
