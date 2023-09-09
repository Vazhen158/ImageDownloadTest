

import Foundation
import SDWebImage

typealias SimpleClosure = () -> Void
typealias ErrorClosure = (Error) -> Void

final class ImageViewModel {
    
    enum SortOrder {
        case ascending
        case descending
        case none
    }

    var currentSortOrder: SortOrder = .none
    private var originalImages: [ImageDownloadEntity] = []
    var images: [ImageDownloadEntity] = []
    {
        didSet {
            originalImages = images
        }
    }
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
    
    func sortImages(by order: SortOrder) {
        switch order {
        case .ascending:
            images.sort { $0.title < $1.title }
        case .descending:
            images.sort { $0.title > $1.title }
        case .none:
            images = originalImages
        }
        
        self.viewUpdate?() 
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

