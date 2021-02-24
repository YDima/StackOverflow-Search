//
//  ViewController.swift
//  StackOverflow-Search
//
//  Created by Alexandr Sopilnyak on 22.02.2021.
//

import UIKit

class ViewController: UIViewController {

  let networkManager: DefaultNetworkManager? = DefaultNetworkManager()
  
  var qID: Int? = 0
  let group = DispatchGroup()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    group.enter()
    networkManager?.search(question: "URLSession swift", page: 1) { [ weak self ] (response, error) in
      
      self?.qID = response?.items.first?.questionID
      print(self?.qID)
      self?.group.leave()
      
    }
    group.notify(queue: .main) {
      self.networkManager?.fetchAnswers(for: self.qID!, page: 1) { (response, error) in
        print(response?.items[0].title)
        print(response?.items[0].description)
      }
    }
    
    
    
  }


}

