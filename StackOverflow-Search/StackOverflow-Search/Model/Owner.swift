//
//  Owner.swift
//  StackOverflow-Search
//
//  Created by Alexandr Sopilnyak on 25.02.2021.
//

import Foundation
struct Owner: Codable {
  private(set) var nickname: String
  private(set) var profileImageURL: String
  
  private enum CodingKeys: String, CodingKey {
    case nickname = "display_name"
    case profileImageURL = "profile_image"
  }
}
