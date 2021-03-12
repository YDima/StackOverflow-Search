//
//  APIEndPoint.swift
//  StackOverflow-Search
//
//  Created by Alexandr Sopilnyak on 24.02.2021.
//

import Foundation

enum QuestionAPIEndPoint {
  
  case search(question: String, page: Int)
  case fetchAnswers(questionID: Int, page: Int)
}

extension QuestionAPIEndPoint: EndPointType {
  
  var baseURL: URL {
    guard let url = URL(string: "https://api.stackexchange.com/2.2/") else {
      fatalError("baseURL incorrect.")
    }
    return url
  }
  
  var path: String {
    switch self {
    case .search(_, _):
      return "search/advanced"
    case .fetchAnswers(let questionID, _):
      return "questions/\(questionID)/answers"
    }
    
  }
  
  var httpMethod: HTTPMethod {
    .get
  }
  
  var task: HTTPTask {
    switch self {
    case .search(let question, let page):
      return .requestParameters(bodyParameters: nil,
                                bodyEncoding: .urlEncoding,
                                urlParameters: ["page": page,
                                                "pagesize": 15,
                                                "sort": "votes",
                                                "order": "desc",
                                                "q": question,
                                                "site": "stackoverflow",
                                                "filter": "withbody"]) // <- this minor error cost you 5 points, don't forget to test your app before submitting
    case .fetchAnswers(_, let page):
      return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["page": page,
                                                                                                 "pagesize": 15,
                                                                                                 "sort": "votes",
                                                                                                 "order": "desc",
                                                                                                 "filter": "!)r(UkltIjB5mA-kUx0R1",
                                                                                                 "site": "stackoverflow"])
    }
  }
  
  var headers: HTTPHeaders? {
    return nil
  }
}
