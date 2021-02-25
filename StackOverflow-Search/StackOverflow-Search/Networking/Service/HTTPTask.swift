//
//  HTTPTask.swift
//  StackOverflow-Search
//
//  Created by Alexandr Sopilnyak on 24.02.2021.
//

import Foundation

public typealias HTTPHeaders = [String: String]

enum HTTPTask {
  
  case request
  case requestParameters(bodyParameters: Parameters?, bodyEncoding: ParameterEncoding, urlParameters: Parameters?)
  case requestParametersAndHeaders(bodyParameters: Parameters?, bodyEncoding: ParameterEncoding, urlParameters: Parameters?,
                                   additionalHeaders: HTTPHeaders?)
}
