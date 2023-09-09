//
//  ImageDetailViewModel.swift
//  ImageDownloadTest
//
//  Created by Андрей Важенов on 09.09.2023.
//

import UIKit

class ImageDetailViewModel {

    private var imageItem: ImageDownloadEntity

    init(imageItem: ImageDownloadEntity) {
        self.imageItem = imageItem
    }

    var title: String? {
        return imageItem.title
    }

    var imageUrl: String? {
        return imageItem.url
    }
}
