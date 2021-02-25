//
//  NetworkResponse.swift
//  StackOverflow-Search
//
//  Created by Alexandr Sopilnyak on 24.02.2021.
//

import Foundation

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "Сould not decode the response."
}

enum Result<String> {
    case success
    case failure(String)
}
