//
//  FavoriteImageCell.swift
//  ImageDownloadTest
//
//  Created by Андрей Важенов on 09.09.2023.
//

import UIKit

class FavoriteImageCell: BaseCollectionViewCell {
    
    @IBOutlet weak var favoriteImage: UIImageView!
    
    @IBOutlet weak var contentCell: UIView!
    
    @IBOutlet weak var favoriteTitle: UILabel!
    
    var updateCollection: SimpleClosure?
    
    private var viewModel: FavoriteImageCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentCell.layer.cornerRadius = 10
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        favoriteImage.image = nil
        favoriteTitle.text = nil
    }
    
    func configure(with viewModel: FavoriteImageCellViewModel) {
        self.viewModel = viewModel
        favoriteImage.sd_setImage(with: viewModel.getImageUrl())
        favoriteTitle.text = viewModel.getTitle()
    }
    
    @IBAction func favoriteDeleteAvtion(_ sender: UIButton) {
        viewModel?.deleteFavorite()
        self.updateCollection?()
    }
}

