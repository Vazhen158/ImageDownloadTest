//
//  FavoriteImageViewController.swift
//  ImageDownloadTest
//
//  Created by Андрей Важенов on 09.09.2023.
//

import UIKit
import RealmSwift

class FavoriteImageViewController: UIViewController {
    
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    private var viewModel = FavoriteImageViewModel()
    weak var delegate: UpdateUI?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setCell()
    }
    
    func setCell() {
        favoriteCollectionView?.register(FavoriteImageCell.uiNib,
                                        forCellWithReuseIdentifier: FavoriteImageCell.cellIdentifierForReg)
        favoriteCollectionView?.showsVerticalScrollIndicator = false
        favoriteCollectionView.dataSource = self
        favoriteCollectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        self.favoriteCollectionView.collectionViewLayout = layout
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
}

extension FavoriteImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = favoriteCollectionView.dequeueReusableCell(withReuseIdentifier: FavoriteImageCell.cellIdentifierForReg,
                                                               for: indexPath) as? FavoriteImageCell {
            if let imageEntity = viewModel.imageDetails(at: indexPath.row) {
                cell.configure(with: FavoriteImageCellViewModel(with: imageEntity))
                cell.updateCollection = { [weak self] in
                    self?.favoriteCollectionView.reloadData()
                    self?.delegate?.reloadUI()
                }
            }
            return cell
            
        }
        return UICollectionViewCell()
    }
}


extension FavoriteImageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacingBetweenCells = 15 
           let totalEdgeInset = 5.0 * 2
           let screenWidth = UIScreen.main.bounds.width

        let cellWidth = (screenWidth - CGFloat(totalSpacingBetweenCells) - CGFloat(totalEdgeInset)) / 2
           
           return CGSize(width: cellWidth, height: cellWidth)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 5.0, bottom: 10.0, right: 5.0)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }

}
