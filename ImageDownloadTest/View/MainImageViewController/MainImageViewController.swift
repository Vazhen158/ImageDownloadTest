//
//  MainImageViewController.swift
//  ImageDownloadTest
//
//  Created by Андрей Важенов on 08.09.2023.
//

import UIKit

class MainImageViewController: UIViewController {
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var photoViewModel: ImageViewModel

    init(imageViewModel: ImageViewModel) {
        self.photoViewModel = imageViewModel
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
        photoViewModel.viewUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.imageCollectionView.reloadData()
            }
        }
    }
    
    func bind() {
        photoViewModel.getImageList()
        photoViewModel.showError = { [weak self] error in
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

}

extension MainImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoViewModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.cellIdentifierForReg,
                                                               for: indexPath) as? ImageCell {
            cell.setModel(model: ImageCellViewModel(imageDownload: photoViewModel.images[indexPath.row]))
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
        return 5
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
