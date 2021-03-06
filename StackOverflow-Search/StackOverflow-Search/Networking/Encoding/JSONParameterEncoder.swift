//
//  JSONParameterEncoder.swift
//  StackOverflow-Search
//
//  Created by Alexandr Sopilnyak on 24.02.2021.
//

import Foundation

struct JSONParameterEncoder: ParameterEncoder {
   func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
    do {
      let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
      urlRequest.httpBody = jsonAsData
      
      if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
        urlRequest.setValue("aplication/json", forHTTPHeaderField: "Content-Type")
      }
    } catch {
      throw NetworkError.encodingFailed
    }
  }
}
