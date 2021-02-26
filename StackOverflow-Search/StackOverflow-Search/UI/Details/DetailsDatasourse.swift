//
//  DetailsDatasourse.swift
//  StackOverflow-Search
//
//  Created by Aliona Starunska on 26.02.2021.
//

import UIKit

class DetailsDatasourse: NSObject, UITableViewDataSource {

    enum Section: Int, CaseIterable {
        case question
        case answer
    }
    
    private var question: Question
    private var items: [Answer] = []
    
    init(question: Question, items: [Answer] = []) {
        self.question = question
        self.items = items
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard Section(rawValue: section) == .answer else { return 1 } 
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if Section(rawValue: indexPath.section) == .question {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? QuestionTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: question)
            return cell
        } else if Section(rawValue: indexPath.section) == .answer {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AnswerTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? AnswerTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: items[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    // MARK: - Public
    
    func set(items: [Answer]) {
        self.items = items
    }
    
    func append(items: [Answer]) -> [IndexPath] {
        let count = self.items.count
        self.items.append(contentsOf: items)
        var indexes = [IndexPath]()
        for idx in 0..<items.count {
            indexes.append(IndexPath(row: count + idx, section: Section.answer.rawValue))
        }
        return indexes
    }
}
