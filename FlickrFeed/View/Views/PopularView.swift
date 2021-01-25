//
//  PopularView.swift
//  FlickrFeed
//
//  Created by Amber Katyal on 16/01/21.
//  Copyright © 2021 Amber Katyal. All rights reserved.
//

import UIKit

final class PopularView: UIView {
    
    // MARK: - Views
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup() {
        backgroundColor = .systemBackground
        addSubview(collectionView)
        collectionView.constrainEdges(toLayoutGuide: self.safeAreaLayoutGuide)
        collectionView.registerClass(PopularCollectionViewCell.self)
    }
}
