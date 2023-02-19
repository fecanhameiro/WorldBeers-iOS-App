//
//  UiViewExtension.swift
//  WorldBeers App
//
//  Created by Felipe C Canhameiro on 19/02/23.
//

import UIKit

extension UIView{
    func cardView() -> Void {
        self.layer.cornerRadius = 12
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 0.5
    }
}
