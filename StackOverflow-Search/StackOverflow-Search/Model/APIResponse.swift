//
//  File.swift
//  StackOverflow-Search
//
//  Created by Alexandr Sopilnyak on 24.02.2021.
//

import Foundation

struct APIResponse<Type: Codable>: Codable {
  
  private(set) var items: [Type]
  private(set) var hasMorePages: Bool
  
  private enum CodingKeys: String, CodingKey {
    case items
    case hasMorePages = "has_more"
  }
  
}
