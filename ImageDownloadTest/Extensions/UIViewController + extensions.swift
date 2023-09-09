//
//  UIViewController + extensions.swift
//  ImageDownloadTest
//
//  Created by Андрей Важенов on 08.09.2023.
//

import UIKit

extension UIViewController {
    func showToast(message: String, interval: Double, complition: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .systemGray3
        alert.view.alpha = 1
        alert.view.layer.cornerRadius = 15

        let cancelAction = UIAlertAction(title: "Ок", style: .cancel) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancelAction)

        self.present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + interval) {
            alert.dismiss(animated: true, completion: nil)
            complition?()
        }
    }
}

