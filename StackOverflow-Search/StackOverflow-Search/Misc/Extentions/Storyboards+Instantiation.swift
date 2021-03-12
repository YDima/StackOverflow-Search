//
//  Storyboards+Instantiation.swift
//  task_4
//
//  Created by Aliona Starunska on 25.12.2020.
//

import UIKit

extension UIStoryboard {
    /**
     Inside this app there are several places where a single controller is defined inside a storyboard file.
     It's better to use .xib files in such cases 🙂.
     */
    func get<T: UIViewController>() -> T? {
        return instantiateViewController(identifier: String(describing: T.self)) as? T
    }
}
