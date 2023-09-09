//
//  StorageManager.swift
//  ImageDownloadTest
//
//  Created by Андрей Важенов on 09.09.2023.
//

import RealmSwift

let realm = try? Realm()


class StorageManager {
    
    static func isItemSaved(imageDownload: ImageDownloadEntity) -> Bool {
        let savedItem = realm?.objects(ImageDownloadEntityRealm.self).filter("id == %@", imageDownload.id).first
            return savedItem != nil
        }
    
    static func deleteObject(_ imageItem: ImageDownloadEntity) {
        try! realm?.write {
            if let itemToDelete = realm?.objects(ImageDownloadEntityRealm.self).filter("id == %@", imageItem.id).first {
                realm?.delete(itemToDelete)
               }
           }
       }
    
    static func deleteFavoriteObject(_ imageItem: ImageDownloadEntityRealm) {
        try? realm?.write {
            if let itemToDelete = realm?.objects(ImageDownloadEntityRealm.self).filter("id == %@", imageItem.id).first {
                realm?.delete(itemToDelete)
            }
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
