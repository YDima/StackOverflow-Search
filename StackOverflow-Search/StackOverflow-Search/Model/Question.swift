//
//  Question.swift
//  StackOverflow-Search
//
//  Created by Alexandr Sopilnyak on 24.02.2021.
//

import Foundation

struct Question: Codable {
  
  private(set) var questionID: Int
  private(set) var title: String?
  private(set) var date: Int?
  private(set) var isAnswered: Bool?
  private(set) var numberOfVotes: Int?
  private(set) var owner: Owner?
  private(set) var body: String?
 
  private enum CodingKeys: String, CodingKey {
   
    case questionID = "question_id"
    case title, owner, body
    case date = "creation_date"
    case isAnswered = "is_answered"
    case numberOfVotes = "score"
  }
}
