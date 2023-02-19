//
//  ImageViewExtension.swift
//  WorldBeers App
//
//  Created by Felipe C Canhameiro on 19/02/23.
//

import UIKit
import SDWebImage

extension UIImageView {
    func loadAsync(from url: URL, withPlaceholder placeholder: UIImage? = nil) {
        self.sd_setImage(with: url, placeholderImage: placeholder) { (image, error, cacheType, url) in
            if let error = error {
                print("Error loading image from url: \(url?.absoluteString ?? "") - \(error.localizedDescription)")
                return
            }
            
        }
    }
}
