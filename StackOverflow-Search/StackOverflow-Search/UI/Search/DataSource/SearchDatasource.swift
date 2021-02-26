//
//  SearchDatasource.swift
//  StackOverflow-Search
//
//  Created by Aliona Starunska on 25.02.2021.
//

import UIKit

class SearchDatasource<Cell: UITableViewCell & ReusableCell & ConfigurableCell>: NSObject, UITableViewDataSource {
    private var items: [Cell.Item] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier,
                                                       for: indexPath) as? Cell else {
            return UITableViewCell()
        }
        cell.configure(with: items[indexPath.row])
        return cell
    }
    
    // MARK: - Public
    
    func set(items: [Cell.Item]) {
        self.items = items
    }
    
    func append(items: [Cell.Item]) -> [IndexPath] {
        let count = self.items.count
        self.items.append(contentsOf: items)
        var indexes = [IndexPath]()
        for idx in 0..<items.count {
            indexes.append(IndexPath(row: count + idx, section: 0))
        }
        return indexes
    }
    
    func item(at index: IndexPath) -> Cell.Item? {
        guard items.indices.contains(index.row) else { return nil }
        return items[index.row]
    }
}
