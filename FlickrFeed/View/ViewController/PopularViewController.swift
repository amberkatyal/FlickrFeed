//
//  PopularViewController.swift
//  FlickrFeed
//
//  Created by Amber Katyal on 14/01/21.
//  Copyright © 2021 Amber Katyal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, HasCustomView {

    typealias CustomView = PopularView
    
    // MARK: - Init
    
    init() {
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
        thisView.tableView.dataSource = self
    }

}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularTableViewCell.id, for: indexPath) as? PopularTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}

