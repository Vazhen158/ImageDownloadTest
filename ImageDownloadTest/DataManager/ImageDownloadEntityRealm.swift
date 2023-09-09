//
//  ImageDownloadEntityRealm.swift
//  ImageDownloadTest
//
//  Created by Андрей Важенов on 09.09.2023.
//

import Foundation
import RealmSwift


class ImageDownloadEntityRealm: Object {
    @objc dynamic var albumId: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var thumbnailUrl: String = ""
}
