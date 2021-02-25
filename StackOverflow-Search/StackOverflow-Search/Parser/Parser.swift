//
//  Parser.swift
//  StackOverflow-Search
//
//  Created by 1 on 25.02.2021.
//

import Foundation
import UIKit

protocol HtmlToSwift {
    
    var html: String { get set }
    
    func getTextVIewFromHtml() -> NSAttributedString?
}

class Parser: HtmlToSwift {
    
    var html: String
    
    init(html: String) { self.html = html }
    
    func getTextVIewFromHtml() -> NSAttributedString? {
        
        guard  html.htmlAttributedString() != nil else { return "getTextVIewFromHtml error parsing".htmlAttributedString() }

        let checkedAtributedString = html.htmlAttributedString()!

        return checkedAtributedString
    }
}
