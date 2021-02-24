//
//  NetworkManager.swift
//  StackOverflow-Search
//
//  Created by Alexandr Sopilnyak on 24.02.2021.
//

import Foundation

protocol NetworkManager {
  associatedtype EndPoint: EndPointType
  var router: Router<EndPoint> { get }
  #warning("TODO: make errors Error type against String")
  func search(question: String, page: Int, completion: @escaping (_ APIdata: APIResponse<Question>?, _ error: String?) -> ())
  func fetchAnswers(for questionID: Int, page: Int, completion: @escaping (_ APIData: APIResponse<Answer>?, _ error: String?) -> ())
}

struct DefaultNetworkManager: NetworkManager {
  let router = Router<QuestionAPIEndPoint>()
  
  func search(question: String, page: Int, completion: @escaping (_ APIdata: APIResponse<Question>?, _ error: String?) -> ()) {
    
    router.request(.search(question: question, page: page)) { (data, response, error) in
      
      guard error == nil else {
        completion(nil, "Network error")
        return
      }
      
      if let response = response as? HTTPURLResponse {
        let result = handleNetworkResponse(response)
        
        switch result {
        case .success:
          guard let data = data else {
            completion(nil, NetworkResponse.noData.rawValue)
            return
            
          }
          
          print(data)
          do {
            let apiResponse = try JSONDecoder().decode(APIResponse<Question>.self, from: data)
            completion(apiResponse, nil)
          } catch {
            completion(nil, NetworkResponse.unableToDecode.rawValue)
          }
          
          
        case .failure(let error):
          completion(nil, error)
        }
      }
    }
    
  }
  
  func fetchAnswers(for questionID: Int, page: Int, completion: @escaping (APIResponse<Answer>?, String?) -> ()) {
    router.request(.fetchAnswers(questionID: questionID, page: page)) { (data, response, error) in
      
      guard error == nil else {
        completion(nil, "Network error")
        return
      }
      
      if let response = response as? HTTPURLResponse {
        let result = handleNetworkResponse(response)
        
        switch result {
        case .success:
          guard let data = data else {
            completion(nil, NetworkResponse.noData.rawValue)
            return
            
          }
          
          print(data)
          do {
            let apiResponse = try JSONDecoder().decode(APIResponse<Answer>.self, from: data)
            completion(apiResponse, nil)
          } catch {
            completion(nil, NetworkResponse.unableToDecode.rawValue)
          }
          
          
        case .failure(let error):
          completion(nil, error)
        }
      }
    }
  }
}


fileprivate extension DefaultNetworkManager {
  func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
    switch response.statusCode {
    case 200...299: return .success
    case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
    case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
    case 600: return .failure(NetworkResponse.outdated.rawValue)
    default: return .failure(NetworkResponse.failed.rawValue)
    }
  }
}
