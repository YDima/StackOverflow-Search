//
//  StringExtension.swift
//  StackOverflow-Search
//
//  Created by 1 on 25.02.2021.
//

import Foundation

extension String {
    func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }

        return try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
        )
    }
}
