//
//  BaseCollectionViewCell.swift
//  ImageDownloadTest
//
//  Created by Андрей Важенов on 08.09.2023.
//

import Foundation
import UIKit

class BaseCollectionViewCell: UICollectionViewCell {

    static var reuseId: String {
        cellIdentifierForReg
    }

    static var uiNib: UINib {
        get {
            return UINib(nibName: String.init(describing: self), bundle: nil)
        }
    }

    static var cellIdentifierForReg: String {
        get {
            return String.init(describing: self)
        }
    }
}
