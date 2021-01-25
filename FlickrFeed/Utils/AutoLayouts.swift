//
//  AutoLayouts.swift
//  FlickrFeed
//
//  Created by Amber Katyal on 17/01/21.
//  Copyright © 2021 Amber Katyal. All rights reserved.
//

import UIKit

extension UIView {
    
    public func constrainEqual(attribute: NSLayoutConstraint.Attribute, to: AnyObject, _ toAttribute: NSLayoutConstraint.Attribute, multiplier: CGFloat = 1, constant: CGFloat = 0) {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: to, attribute: toAttribute, multiplier: multiplier, constant: constant)
            ])
    }
    
    public func constrainEdges(to view: UIView, margin: Bool = false) {
        constrainEqual(attribute: .top, to: view, margin ? .topMargin : .top)
        constrainEqual(attribute: .bottom, to: view, margin ? .bottomMargin : .bottom)
        constrainEqual(attribute: .leading, to: view, margin ? .leadingMargin : .leading)
        constrainEqual(attribute: .trailing, to: view, margin ? .trailingMargin : .trailing)
    }
    
    public func constrainEdges(toLayoutGuide guide: UILayoutGuide) {
        constrainEqual(attribute: .top, to: guide, .top)
        constrainEqual(attribute: .bottom, to: guide, .bottom)
        constrainEqual(attribute: .leading, to: guide, .leading)
        constrainEqual(attribute: .trailing, to: guide, .trailing)
    }
    
    public func center(in view: UIView) {
        centerXAnchor.constrainEqual(anchor: view.centerXAnchor)
        centerYAnchor.constrainEqual(anchor: view.centerYAnchor)
    }
    
}


extension NSLayoutAnchor {
    
    @objc @discardableResult public func constrainEqual(anchor: NSLayoutAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = self.constraint(equalTo: anchor, constant: constant)
        constraint.isActive = true
        return constraint
    }
}
