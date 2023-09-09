//
//  ImageDetailViewController.swift
//  ImageDownloadTest
//
//  Created by Андрей Важенов on 09.09.2023.
//

import UIKit
import SDWebImage

class ImageDetailViewController: UIViewController {
    
    @IBOutlet weak var detailImage: UIImageView!
    
    @IBOutlet weak var titleImage: UILabel!

    var viewModel: ImageDetailViewModel
    
    init(model: ImageDetailViewModel) {
        self.viewModel = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupUI()
    }
    
    func setupUI() {
        titleImage.text = viewModel.title
        guard let image = viewModel.imageUrl, let url = URL(string: image) else { return }
        
        if let cachedImage = ImageViewModel().getCachedImage(for: image) {
            detailImage.image = cachedImage
        } else {
            detailImage.sd_setImage(with: url)
        }
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
}
