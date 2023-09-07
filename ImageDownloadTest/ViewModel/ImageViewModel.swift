

import Foundation

typealias SimpleClosure = () -> Void
typealias ErrorClosure = (Error) -> Void

final class ImageViewModel {
    
    var images: [ImageDownloadEntity] = []
    var downLoadImage: ImageDownload
    var viewUpdate: SimpleClosure?
    var showError: ErrorClosure?
    
    init(downLoad: ImageDownload = ImageDownload()) {
        self.downLoadImage = downLoad
    }
    
    func getImageList() {
        downLoadImage.downloadData { [weak self] result in
            switch result {
            case .success(let response):
                self?.images = response
                self?.viewUpdate?()
            case .failure(let error):
                self?.showError?(error)
            }
        }
    }
    
}
