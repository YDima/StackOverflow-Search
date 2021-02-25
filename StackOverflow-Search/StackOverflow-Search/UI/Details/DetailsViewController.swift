//
//  DetailsViewController.swift
//  StackOverflow-Search
//
//  Created by Aliona Starunska on 24.02.2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.register(QuestionTableViewCell.self)
        tableView.register(AnswerTableViewCell.self)

    }
    
}
