//
//  Router.swift
//  StackOverflow-Search
//
//  Created by Alexandr Sopilnyak on 24.02.2021.
//

import Foundation

class Router<EndPoint: EndPointType>: NetworkRouter {
  private var task: URLSessionTask?
  
  func request(_ route: EndPoint, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
    
    do {
      let request = try self.buildRequest(from: route)
      task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
        completion(data, response, error)
      })
    } catch {
      completion(nil, nil, error)
    }
    self.task?.resume()
  }
  
  func cancell() {
    self.task?.cancel()
  }
  
}

fileprivate extension Router {
  func buildRequest(from route: EndPoint) throws -> URLRequest {
    
    var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                             cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                             timeoutInterval: 10.0)
    
    request.httpMethod = route.httpMethod.rawValue
    
    do {
      
      switch route.task {
      case .request:
        request.setValue("aplication/json", forHTTPHeaderField: "Content-Type")
        
      case .requestParameters(let bodyParameters, let bodyEncoding, let urlParameters):
        try self.configureParameters(bodyParameters: bodyParameters, bodyEncoding: bodyEncoding,
                                     urlParameters: urlParameters, request: &request)
        
      case .requestParametersAndHeaders(let bodyParameters, let bodyEncoding, let urlParameters, let additionalHeaders):
        self.additionalHeaders(additionalHeaders, &request)
        try self.configureParameters(bodyParameters: bodyParameters, bodyEncoding: bodyEncoding,
                                     urlParameters: urlParameters, request: &request)
      }
      
      return request
      
    } catch {
      throw error
    }
    
  }
  
  func configureParameters(bodyParameters: Parameters?,
                           bodyEncoding: ParameterEncoding,
                           urlParameters: Parameters?,
                           request: inout URLRequest) throws {
    do {
      try bodyEncoding.encode(urlRequest: &request, bodyParameters: bodyParameters, urlParameters: urlParameters)
      
    } catch {
      throw error
    }
  }
  
  func additionalHeaders(_ additionalHeaders: HTTPHeaders?, _ request: inout URLRequest) {
    guard let headers = additionalHeaders else { return }
      for (key, value) in headers {
        request.setValue(value, forHTTPHeaderField: key)
      }
  }
}
