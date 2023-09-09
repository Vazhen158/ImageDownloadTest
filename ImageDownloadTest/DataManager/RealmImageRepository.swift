//
//  RealmImageRepository.swift
//  ImageDownloadTest
//
//  Created by Андрей Важенов on 09.09.2023.
//

import Foundation
import RealmSwift

protocol ImageRepository {
    func fetchFavoriteImages() -> Results<ImageDownloadEntityRealm>?
}

class RealmImageRepository: ImageRepository {
    
    private var realm: Realm?

    init(realm: Realm? = try? Realm()) {
        self.realm = realm
    }
    
    func fetchFavoriteImages() -> Results<ImageDownloadEntityRealm>? {
        return realm?.objects(ImageDownloadEntityRealm.self)
    }
}
