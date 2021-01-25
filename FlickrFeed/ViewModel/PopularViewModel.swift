//
//  PopularViewModel.swift
//  FlickrFeed
//
//  Created by Amber Katyal on 17/01/21.
//  Copyright © 2021 Amber Katyal. All rights reserved.
//

import Foundation

final class PopularViewModel {

    private let photosService: PhotosService

    private let dataSource: CollectionViewViewDataSource<FlickrPhoto,PopularCollectionViewCell>
    private var paging = PagingGenerator<FlickrPhoto>(page: 1, limit: 25)
    
    init() {
        self.photosService = PhotosService()
        self.dataSource = CollectionViewViewDataSource(models: [], cellIdentifier: PopularCollectionViewCell.identifier) { (_, _) in
            
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
        
    }
}
