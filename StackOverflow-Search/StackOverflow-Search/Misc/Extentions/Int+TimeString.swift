//
//  Int+TimeString.swift
//  StackOverflow-Search
//
//  Created by Aliona Starunska on 25.02.2021.
//

import Foundation

extension Int {
    var timeString: String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy', 'HH:mm"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
}
