//
//  PopularViewController.swift
//  FlickrFeed
//
//  Created by Amber Katyal on 14/01/21.
//  Copyright © 2021 Amber Katyal. All rights reserved.
//

import UIKit

class PopularViewController: UIViewController, HasCustomView {
    
    typealias CustomView = PopularView
    
    // MARK: - Properties
    private let viewModel: PopularViewModel
    
    // MARK: - Init

    init(viewModel: PopularViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        self.view = PopularView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.reloadData = { [weak self] in
            self?.thisView.collectionView.reloadData()
        }
        viewModel.load()
    }
}

extension PopularViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard collectionView.isDragging || collectionView.isTracking else { return }
        if indexPath.item == collectionView.numberOfItems(inSection: 0)-1 {
            viewModel.nextPage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/2
        return CGSize(width: width, height: width)
    }
}
