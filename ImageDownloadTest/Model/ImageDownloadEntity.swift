//
//  ImageDownloadEntity.swift
//  ImageDownloadTest
//
//  Created by Андрей Важенов on 08.09.2023.
//

import Foundation

struct ImageDownloadEntity: Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
