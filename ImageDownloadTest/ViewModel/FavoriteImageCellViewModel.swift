//
//  FavoriteImageCellViewModel.swift
//  ImageDownloadTest
//
//  Created by Андрей Важенов on 09.09.2023.
//

import Foundation

final class FavoriteImageCellViewModel {

    private var imageUrl: String?
    private var title: String?

    private var imageEntity: ImageDownloadEntityRealm
    
    init(with entity: ImageDownloadEntityRealm) {
        self.imageEntity = entity
        self.imageUrl = entity.thumbnailUrl
        self.title = entity.title
    }

    func getImageUrl() -> URL? {
        return URL(string: imageUrl ?? "")
    }
    
    func getTitle() -> String? {
        return title
    }
    
    func deleteFavorite() {
        StorageManager.deleteObject(imageEntity)
    }
}
