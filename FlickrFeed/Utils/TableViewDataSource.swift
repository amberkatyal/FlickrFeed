//
//  TableViewDataSource.swift
//  FlickrFeed
//
//  Created by Amber Katyal on 17/01/21.
//  Copyright © 2021 Amber Katyal. All rights reserved.
//

import UIKit

final class TableViewDataSource<Model, Cell: ReusableView>: NSObject, UITableViewDataSource where Cell: UITableViewCell {
    
    typealias CellConfigurator = (Model, Cell) -> Void

    private let models: [Model]
    private let cellIdentifier: String
    private let cellConfigurator: CellConfigurator
    
    required init(models: [Model], cellIdentifier: String, cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.cellIdentifier = cellIdentifier
        self.cellConfigurator = cellConfigurator
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell: Cell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cellConfigurator(model, cell)
        return cell
    }
    
}
