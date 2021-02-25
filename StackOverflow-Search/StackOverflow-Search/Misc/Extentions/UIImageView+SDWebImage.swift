//
//  UIImageView+SDWebImage.swift
//  StackOverflow-Search
//
//  Created by Aliona Starunska on 25.02.2021.
//

import Foundation
import SDWebImage

extension UIImageView {
    var url: String? {
        get {
            return nil
        }
        set {
            guard let urlString = newValue, let url = URL(string: urlString) else {
                image = nil
                return
            }
            sd_setImage(with: url, completed: nil)
        }
    }
}
