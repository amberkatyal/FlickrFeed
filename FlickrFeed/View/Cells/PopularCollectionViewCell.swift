//
//  PopularCollectionViewCell.swift
//  FlickrFeed
//
//  Created by Amber Katyal on 25/01/21.
//  Copyright © 2021 Amber Katyal. All rights reserved.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell, ReusableView {

    // MARK: - Views
    let popularImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        return imgView
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
        contentView.addSubview(popularImageView)
        popularImageView.constrainEdges(to: contentView)
    }
}
