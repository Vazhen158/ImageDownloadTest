//
//  ImageCell.swift
//  ImageDownloadTest
//
//  Created by Андрей Важенов on 08.09.2023.
//

import Foundation
import UIKit

class ImageCell: UICollectionViewCell {
    
    
    @IBOutlet weak var downloadImage: UIImageView!
    
    @IBOutlet weak var titleImage: UILabel!
    
    @IBOutlet weak var contentCell: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        downloadImage.image = nil
        titleImage.text = nil

    }
    
    @IBAction func favoriteButtonAction(_ sender: UIButton) {
        
    }
    
}
