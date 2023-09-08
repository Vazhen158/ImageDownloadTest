

import Foundation
import SDWebImage

typealias SimpleClosure = () -> Void
typealias ErrorClosure = (Error) -> Void

final class ImageViewModel {
    
    var images: [ImageDownloadEntity] = []
    var downLoadImage: ImageDownload
    var viewUpdate: SimpleClosure?
    var showError: ErrorClosure?
    
    var page: Int = 1
    let limit: Int = 10
    var hasMoreImages: Bool = true
    var isLoading: Bool = false
    
    init(downLoad: ImageDownload = ImageDownload()) {
        self.downLoadImage = downLoad
    }
    
    func getImageList() {
        guard hasMoreImages && !isLoading else { return }
            
            isLoading = true
        
        downLoadImage.downloadData(page: page, limit: limit) { [weak self] result in
            self?.isLoading = false
            guard let strongSelf = self else { return }
            
            switch result {
            case .success(let response):
                if response.isEmpty || response.count < strongSelf.limit {
                    strongSelf.hasMoreImages = false
                }
                
                strongSelf.images.append(contentsOf: response)
                strongSelf.cacheImages(from: response)
                
                strongSelf.page += 1
                strongSelf.viewUpdate?()
            case .failure(let error):
                strongSelf.showError?(error)
            }
        }
    }
    
    private func cacheImages(from entities: [ImageDownloadEntity]) {
        for imageEntity in entities {
            if let imageUrl = URL(string: imageEntity.thumbnailUrl) {
                SDWebImageManager.shared.loadImage(with: imageUrl, options: .highPriority, progress: nil) { (image, _, _, _, _, _) in
                    SDImageCache.shared.store(image, forKey: imageEntity.thumbnailUrl, completion: nil)
                }
            }
        }
    }
    
    func getCachedImage(for imageUrl: String) -> UIImage? {
        return SDImageCache.shared.imageFromCache(forKey: imageUrl)
    }
}

