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
        self.viewModel = model
        guard let item = viewModel else { return }
        downloadImage.sd_setImage(with: URL(string: item.imageItem.thumbnailUrl) )
        titleImage.text = item.imageItem.title
    }
    
    func setupUI() {
        contentCell.layer.cornerRadius = 10
    }
    
    @IBAction func favoriteButtonAction(_ sender: UIButton) {
        
    }
    
}
