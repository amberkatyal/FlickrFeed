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
        thisView.collectionView.dataSource = viewModel.dataSource
        thisView.collectionView.delegate = self
        viewModel.load()
        thisView.segmentControl.addTarget(self, action: #selector(didTapSegment(_:)), for: .valueChanged)
    }
    
    // MARK: - Actions
    @objc func didTapSegment(_ segment: UISegmentedControl) {
        if let columnsString = segment.titleForSegment(at: segment.selectedSegmentIndex), let columns = Int(columnsString) {
            viewModel.columns = columns
            thisView.collectionView.setCollectionViewLayout(thisView.collectionViewLayout, animated: true)
        }
    }
}

extension PopularViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let offsetY = collectionView.contentOffset.y
        let contentHeight = collectionView.contentSize.height
        let offset = offsetY > contentHeight - collectionView.frame.size.height
        let userScroll = (collectionView.isDragging && collectionView.isDecelerating) || collectionView.isTracking
        let lastItem = indexPath.item == collectionView.numberOfItems(inSection: 0)-1
        if offset || (lastItem && userScroll) {
            viewModel.nextPage()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = thisView.frame.width/CGFloat(viewModel.columns)
        return CGSize(width: width, height: width)
    }
    
}
