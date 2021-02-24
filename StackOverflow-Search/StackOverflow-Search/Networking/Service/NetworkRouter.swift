//
//  NetworkRouter.swift
//  StackOverflow-Search
//
//  Created by Alexandr Sopilnyak on 24.02.2021.
//

import Foundation

protocol NetworkRouter: class {
  associatedtype EndPoint: EndPointType
  
  func request(_ route: EndPoint, completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ())
  func cancell()
}

