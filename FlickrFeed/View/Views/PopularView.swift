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
    let segmentControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["2", "3", "4"])
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.selectedSegmentIndex = 0
        return segment
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
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
        addSubview(segmentControl)
        let safeArea = safeAreaLayoutGuide
        segmentControl.centerXAnchor.constrainEqual(anchor: centerXAnchor)
        segmentControl.topAnchor.constrainEqual(anchor: safeArea.topAnchor)
        segmentControl.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5, constant: 0).isActive = true
        addSubview(collectionView)
        collectionView.leadingAnchor.constrainEqual(anchor: safeArea.leadingAnchor)
        collectionView.trailingAnchor.constrainEqual(anchor: safeArea.trailingAnchor)
        collectionView.bottomAnchor.constrainEqual(anchor: safeArea.bottomAnchor)
        collectionView.topAnchor.constrainEqual(anchor: segmentControl.bottomAnchor, constant: 8)
        collectionView.registerClass(PopularCollectionViewCell.self)
    }
}
