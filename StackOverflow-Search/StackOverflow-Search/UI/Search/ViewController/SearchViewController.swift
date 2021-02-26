//
//  SearchViewController.swift
//  StackOverflow-Search
//
//  Created by Aliona Starunska on 22.02.2021.
//

import UIKit

class SearchViewController: UIViewController, ErrorDisplaying {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    @IBOutlet private weak var centerConstraint: NSLayoutConstraint!
    private var footer: LoadingFooterView?
    
    private var datasource = SearchDatasource<SearchCell>()
    private var searchTask: DispatchWorkItem?
    private var networkService = DefaultNetworkManager()
    private var page: Int = 1
    private var isLoadingMore = false {
        didSet {
            guard canLoadMore else {
                footer?.endLoading()
                return
            }
            isLoadingMore ? footer?.startLoading() : footer?.endLoading()
        }
    }
    private var canLoadMore = false {
        didSet {
            if !canLoadMore {
                footer?.endLoading()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SearchCell.self)
        tableView.dataSource = datasource
        searchBar.backgroundImage = UIImage()
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    // MARK: - Private
    
    private func search(_ query: String) {
        searchTask?.cancel()
        self.page = 1
        let task = DispatchWorkItem { [weak self] in
            self?.networkService.search(question: query, page: self?.page ?? 1, completion: { (questions, _) in
                DispatchQueue.main.async {
                    self?.canLoadMore = questions?.hasMorePages ?? false
                    self?.datasource.set(items: questions?.items ?? [])
                    self?.tableView.reloadData()
                    guard questions?.items.isEmpty == false else { return }
                    self?.animateSearchbarTop()
                }
            })
        }
        searchTask = task
        DispatchQueue.main.asyncAfter(deadline: .now() + .delay, execute: task)
    }
    
    private func loadMoreQuestions() {
        guard !isLoadingMore else { return }
        guard canLoadMore else { return }
        isLoadingMore = true
        page += 1
        networkService.search(question: searchBar.text ?? "", page: self.page, completion: { [weak self] (questions, error) in
            DispatchQueue.main.async {
                self?.isLoadingMore = false
                if let error = error {
                    self?.page -= 1
                    self?.show(errorString: error)
                    return
                }
                self?.canLoadMore = questions?.hasMorePages ?? false
                guard let indexes = self?.datasource.append(items: questions?.items ?? []), !indexes.isEmpty else { return }
                self?.tableView.insertRows(at: indexes, with: .none)
            }
        })
    }
    
    private func animateSearchbarTop() {
        UIView.animate(withDuration: .animationDuration) { [weak self] in
            self?.topConstraint.priority = .defaultHigh
            self?.centerConstraint.priority = .defaultLow
            self?.view.layoutIfNeeded()
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let resultText = (searchBar.text as NSString?)?.replacingCharacters(in: range, with: text) {
            search(resultText)
        }
        return true
    }
}

extension SearchViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
        let height = scrollView.frame.height
        let contentSizeHeight = scrollView.contentSize.height
        let offset = scrollView.contentOffset.y
        let reachingBottom = (offset + height + .searchTreshold >= contentSizeHeight)
        
        if reachingBottom {
            loadMoreQuestions()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let question = datasource.item(at: indexPath) else { return }
        let storyboard = UIStoryboard(name: String(describing: DetailsViewController.self), bundle: nil)
        guard let vc: DetailsViewController = storyboard.get() else { return }
        if let question = question { // IDK why compiler forced me to unwrap again
            vc.set(question: question)
        }
        present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UITableViewHeaderFooterView.init(frame: CGRect.init(x: .zero, y: .zero,
                                                                       width: tableView.bounds.width, height: .footerHeight))
        view.contentView.backgroundColor = .clear
        guard let footer = LoadingFooterView.instantiateFromNib() else { return view }
        self.footer = footer
        view.addSubview(footer)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .footerHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.frame = CGRect.init(x: .zero, y: .zero, width: tableView.bounds.width, height: .footerHeight)
        view.subviews.forEach({ $0.frame = view.bounds })
        view.layoutIfNeeded()
        if let footer = view.subviews.compactMap({ $0 as? LoadingFooterView }).first {
            guard canLoadMore else {
                footer.endLoading()
                return
            }
            isLoadingMore ? footer.startLoading() : footer.endLoading()
        }
    }
}

// MARK: - Constants

private extension TimeInterval {
    static var delay: TimeInterval { return 1 }
    static var animationDuration: TimeInterval { return 0.4 }
}

private extension CGFloat {
    static var searchTreshold: CGFloat { return 200 }
    static var footerHeight: CGFloat { return 44 }
}
