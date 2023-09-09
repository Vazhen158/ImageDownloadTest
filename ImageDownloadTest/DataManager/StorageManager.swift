//
//  StorageManager.swift
//  ImageDownloadTest
//
//  Created by Андрей Важенов on 09.09.2023.
//

import RealmSwift

let realm = try? Realm()


class StorageManager {
    
    static func deleteObject(_ imageItem: ImageDownloadEntityRealm) {
        try? realm?.write {
            realm?.delete(imageItem)
        }
    }
    
    static func saveToRealm(imageDownload: ImageDownloadEntity) {
            let realmEntity = ImageDownloadEntityRealm()
            realmEntity.albumId = imageDownload.albumId
            realmEntity.id = imageDownload.id
            realmEntity.title = imageDownload.title
            realmEntity.url = imageDownload.url
            realmEntity.thumbnailUrl = imageDownload.thumbnailUrl
            
            let realm = try? Realm()
        try? realm?.write {
                realm?.add(realmEntity)
            }
        }
    
}
