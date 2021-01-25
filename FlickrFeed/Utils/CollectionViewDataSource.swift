//
//  CollectionViewDataSource.swift
//  FlickrFeed
//
//  Created by Amber Katyal on 25/01/21.
//  Copyright © 2021 Amber Katyal. All rights reserved.
//

import UIKit

final class CollectionViewViewDataSource<Model, Cell: ReusableView>: NSObject, UICollectionViewDataSource where Cell: UICollectionViewCell {
    
    typealias CellConfigurator = (Model, Cell) -> Void

    private var models: [Model]
    private let cellIdentifier: String
    private let cellConfigurator: CellConfigurator
    
    required init(models: [Model], cellIdentifier: String, cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.cellIdentifier = cellIdentifier
        self.cellConfigurator = cellConfigurator
        super.init()
    }
    
    func append(dataSource data: [Model]) {
        self.models.append(contentsOf: data)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = models[indexPath.item]
        let cell: Cell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cellConfigurator(model, cell)
        return cell
    }
    
}
