//
//  Answer.swift
//  StackOverflow-Search
//
//  Created by Alexandr Sopilnyak on 25.02.2021.
//

import Foundation

/*
 var date: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // https://nsdateformatter.com
        return formatter.date(from: dateString ?? "")
    }

*/

struct Answer: Codable {
  private(set) var title: String
  private(set) var description: String
  private(set) var date: Int
  private(set) var isAccepted: Bool
  private(set) var numberOfVotes: Int
  private(set) var owner: Owner
  
  private enum CodingKeys: String, CodingKey {
    
    case title
    case description = "body"
    case date = "creation_date"
    case isAccepted = "is_accepted"
    case numberOfVotes = "score"
    case owner
    
  }
}
