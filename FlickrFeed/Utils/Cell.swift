//
//  ReusableView.swift
//  FlickrFeed
//
//  Created by Amber Katyal on 17/01/21.
//  Copyright © 2021 Amber Katyal. All rights reserved.
//

import UIKit

/// This protocol abstracts away the default implementation of Any custom cell
protocol ReusableView: class {
    static var nib: UINib { get }
    static var identifier: String { get }
}

extension ReusableView {
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
