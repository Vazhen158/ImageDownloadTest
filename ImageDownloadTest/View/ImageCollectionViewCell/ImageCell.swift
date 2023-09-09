//
//  ImageCell.swift
//  ImageDownloadTest
//
//  Created by Андрей Важенов on 08.09.2023.
//

import UIKit
import SDWebImage

class ImageCell: BaseCollectionViewCell {
    
    var viewModel: ImageCellViewModel?
    
    @IBOutlet weak var downloadImage: UIImageView!
    
    @IBOutlet weak var titleImage: UILabel!
    
    @IBOutlet weak var contentCell: UIView!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var showAlert: SimpleClosure?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        downloadImage.image = nil
        titleImage.text = nil
    }
    
    func setModel(model: ImageCellViewModel) {
        activityIndicator.startAnimating()
        self.viewModel = model
        guard let item = viewModel else { return }
        downloadImage.sd_setImage(with: URL(string: item.imageItem.thumbnailUrl), completed: { [weak self] (_, _, _, _) in
               self?.activityIndicator.stopAnimating()
               self?.activityIndicator.isHidden = true
           })
        titleImage.text = item.imageItem.title
    }
    
    func configureCachedUI(item: ImageCellViewModel, image: UIImage) {
        downloadImage.image = image
        titleImage.text = item.imageItem.title
        viewModel = item
    }
    
    func setupUI() {
        contentCell.layer.cornerRadius = 10
        activityIndicator.isHidden = true
    }
    
    @IBAction func favoriteButtonAction(_ sender: UIButton) {
        guard let imageItem = viewModel?.imageItem else { return }
        StorageManager.saveToRealm(imageDownload: imageItem)
        self.showAlert?()
    }
    
}
