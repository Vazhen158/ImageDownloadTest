//
//  FavoriteImageViewModel.swift
//  ImageDownloadTest
//
//  Created by Андрей Важенов on 09.09.2023.
//

import UIKit
import RealmSwift

class FavoriteImageViewModel {

    private var favoriteImages: Results<ImageDownloadEntityRealm>?

       private let repository: ImageRepository

       init(repository: ImageRepository = RealmImageRepository()) {
           self.repository = repository
           self.favoriteImages = self.repository.fetchFavoriteImages()
       }

    var numberOfItems: Int {
        return favoriteImages?.count ?? 0
    }

    func imageDetails(at index: Int) -> ImageDownloadEntityRealm? {
        guard index >= 0 && index < numberOfItems else { return nil }
        return favoriteImages?[index]
    }

}

