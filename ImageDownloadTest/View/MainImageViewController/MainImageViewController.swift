//
//  MainImageViewController.swift
//  ImageDownloadTest
//
//  Created by Андрей Важенов on 08.09.2023.
//

import UIKit

class MainImageViewController: UIViewController {
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var imageViewModel: ImageViewModel

    init(imageViewModel: ImageViewModel) {
        self.imageViewModel = imageViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCell()
        bind()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageViewModel.viewUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.imageCollectionView.reloadData()
            }
        }
    }
    
    func bind() {
        imageViewModel.getImageList()
        imageViewModel.showError = { [weak self] error in
            self?.showToast(message: error.localizedDescription, interval: 4)
        }
    }
    
    func setCell() {
        imageCollectionView?.register(ImageCell.uiNib,
                                        forCellWithReuseIdentifier: ImageCell.cellIdentifierForReg)
        imageCollectionView?.showsVerticalScrollIndicator = false
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        self.imageCollectionView.collectionViewLayout = layout
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.height * 1.5 {
            if imageViewModel.hasMoreImages {
                imageViewModel.getImageList()
            }
        }
    }

}

extension MainImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageViewModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.cellIdentifierForReg,
                                                               for: indexPath) as? ImageCell {
            cell.setModel(model: ImageCellViewModel(imageDownload: imageViewModel.images[indexPath.row]))
            return cell
            
        }
        return UICollectionViewCell()
    }
}


extension MainImageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width - 40
        return CGSize(width: screenWidth, height: screenWidth)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 0.0, bottom: 10.0, right: 0.0)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
