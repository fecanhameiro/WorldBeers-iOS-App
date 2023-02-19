//
//  ImageViewExtension.swift
//  WorldBeers App
//
//  Created by Felipe C Canhameiro on 19/02/23.
//

import UIKit

extension UIImageView {
    func loadAsync(from url: URL, withPlaceholder placeholder: UIImage? = nil) {
        self.image = placeholder
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        activityIndicator.hidesWhenStopped = true
        self.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error loading image from url: \(url.absoluteString) - \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}
