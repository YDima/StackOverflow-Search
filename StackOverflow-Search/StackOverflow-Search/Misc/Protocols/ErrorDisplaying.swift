//
//  ErrorDisplaying.swift
//  StackOverflow-Search
//
//  Created by Aliona Starunska on 25.02.2021.
//

import UIKit
import SwiftMessages

protocol ErrorDisplaying where Self: UIViewController {
    func show(errorString: String)
    func show(error: Error)
}

extension ErrorDisplaying {
    
    func show(errorString: String) {
        guard !errorString.isEmpty else { return }
        var config = SwiftMessages.Config()
        config.presentationStyle = .top
        config.duration = .seconds(seconds: 3)
        config.interactiveHide = true
        config.presentationContext = .window(windowLevel: .normal)
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureContent(title: nil, body: errorString, iconImage: Asset.Assets.error.image,
                              iconText: nil, buttonImage: nil, buttonTitle: nil, buttonTapHandler: nil)
        view.shadowColor = .black
        view.shadowRadius = 8.0
        view.shadowOpacity = 0.4
        view.shadowOffset = CGSize(width: 1, height: 6)
        SwiftMessages.sharedInstance.pauseBetweenMessages = 0.1
        SwiftMessages.show(config: config, view: view)
    }
    
    func show(error: Error) {
        show(errorString: error.localizedDescription)
    }
}
