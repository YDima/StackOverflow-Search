//
//  NetworkError.swift
//  StackOverflow-Search
//
//  Created by Alexandr Sopilnyak on 24.02.2021.
//

import Foundation

enum NetworkError: String, Error {
  case missingParameters = "Parameters missing. Check it could be nil."
  case encodingFailed = "Encoding process failed."
  case missingURL = "URL is nil."
}
