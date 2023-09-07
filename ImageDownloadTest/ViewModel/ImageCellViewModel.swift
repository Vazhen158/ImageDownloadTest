//
//  ImageCellViewModel.swift
//  ImageDownloadTest
//
//  Created by Андрей Важенов on 08.09.2023.
//

import UIKit


final class ImageCellViewModel {
    var imageItem: ImageDownloadEntity
    var downLoadImage: ImageDownload
    
    init(imageDownload: ImageDownloadEntity, download: ImageDownload = ImageDownload()) {
        self.imageItem = imageDownload
        self.downLoadImage = download
    }
}
