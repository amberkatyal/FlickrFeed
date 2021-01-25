//
//  PopularViewModel.swift
//  FlickrFeed
//
//  Created by Amber Katyal on 17/01/21.
//  Copyright © 2021 Amber Katyal. All rights reserved.
//

import Foundation

final class PopularViewModel {

    var reloadData: (()->Void)? = nil
    private let photosService: PhotosService

    let dataSource: CollectionViewViewDataSource<FlickrPhoto,PopularCollectionViewCell>
    private var paging = PagingGenerator<FlickrPhoto>(page: 1, limit: 25)
    
    init() {
        self.photosService = PhotosService()
        self.dataSource = CollectionViewViewDataSource<FlickrPhoto, PopularCollectionViewCell>(models: [], cellIdentifier: PopularCollectionViewCell.identifier) { (model, cell) in
            cell.setImage(from: model.imageURL)
        }
    }

    func load() {
        nextPage()
    }
    
    func nextPage() {
        paging.next(fetchNextBatch: fetchNextBatch, onFinish: updateDataSource)
    }
    
    private func fetchNextBatch(page: Int, limit: Int, completion: @escaping ([FlickrPhoto]) -> Void) -> Void {
        photosService.fetchPopularPhotos(batchSize: limit, page: page) { result in
            switch result {
            case .success(let page):
                completion(page.photo)
            case .failure:
                break
            }
        }
    }
    
    private func updateDataSource(items: [FlickrPhoto]) {
        self.dataSource.append(dataSource: items)
        DispatchQueue.main.async {
            self.reloadData?()
        }
    }
}
