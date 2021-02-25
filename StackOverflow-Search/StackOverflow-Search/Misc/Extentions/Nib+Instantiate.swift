//
//  Nib+Instantiate.swift
//  StackOverflow-Search
//
//  Created by Aliona Starunska on 25.02.2021.
//

import UIKit

private extension UINib {

    func instantiate() -> Any? {
        return instantiate(withOwner: nil, options: nil).first
    }
}
extension UIView {
    
    static func nib(with name: String? = nil) -> UINib {
        let nibName = name ?? "\(self)"
        return UINib(nibName: nibName, bundle: nil)
    }

    static func instantiateFromNib(with name: String? = nil) -> Self? {
        func instanceFromNib<T: UIView>() -> T? {
            return nib(with: name).instantiate() as? T
        }
        return instanceFromNib()
    }
}
