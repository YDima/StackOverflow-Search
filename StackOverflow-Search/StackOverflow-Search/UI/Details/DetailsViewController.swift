//
//  DetailsViewController.swift
//  StackOverflow-Search
//
//  Created by Aliona Starunska on 24.02.2021.
//

import UIKit

class DetailsViewController: UIViewController, ErrorDisplaying {
    
    @IBOutlet weak var tableView: UITableView!
    private var footer: LoadingFooterView?
    
    private var datasource: DetailsDatasourse?
    private var networkService = DefaultNetworkManager()
    private var page: Int = 0
    private var question: Question?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let question = question {
            datasource = DetailsDatasourse(question: question)
        }
        tableView.register(QuestionTableViewCell.self)
        tableView.register(AnswerTableViewCell.self)
        tableView.dataSource = datasource
        tableView.estimatedRowHeight = UITableView.automaticDimension
        loadMoreAnswers()
    }
    
    private var isLoadingMore = false {
        didSet {
            guard canLoadMore else {
                footer?.endLoading()
                return
            }
            isLoadingMore ? footer?.startLoading() : footer?.endLoading()
        }
    }
    private var canLoadMore = true {
        didSet {
            if !canLoadMore {
                footer?.endLoading()
            }
        }
    }
    
    // MARK: - Private
    
    /*
     Try to find more than 1 difference between this method and the `loadMoreQuestions` method
     from the SearchViewController. This code shouldn't be copypasted, it's an error. You should move
     such code to an abstraction, using class composition is more preferrable in such cases, but inheritance
     will be ok aswell.
     */
    private func loadMoreAnswers() {
        guard !isLoadingMore else { return }
        guard canLoadMore else { return }
        isLoadingMore = true
        page += 1
        networkService.fetchAnswers(for: question?.questionID ?? 0, page: page) { [weak self] (response, error) in
            DispatchQueue.main.async {
                self?.isLoadingMore = false
                if let error = error {
                    self?.page -= 1
                    self?.show(errorString: error)
                    return
                }
                self?.canLoadMore = response?.hasMorePages ?? false
                guard let indexes = self?.datasource?.append(items: response?.items ?? []), !indexes.isEmpty else { return }
                self?.tableView.insertRows(at: indexes, with: .none)
            }
        }
    }
}

extension DetailsViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.height
        let contentSizeHeight = scrollView.contentSize.height
        let offset = scrollView.contentOffset.y
        let reachingBottom = (offset + height + .searchTreshold >= contentSizeHeight)
        
        if reachingBottom {
            loadMoreAnswers()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard DetailsDatasourse.Section(rawValue: section) == .answer else { return nil }
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
        guard DetailsDatasourse.Section(rawValue: section) == .answer else { return .leastNormalMagnitude }
        return .footerHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        guard DetailsDatasourse.Section(rawValue: section) == .answer else { return }
        view.frame = CGRect.init(x: .zero, y: .zero, width: tableView.bounds.width, height: .footerHeight)
        view.subviews.forEach({ $0.frame = view.bounds })
        view.layoutIfNeeded()
        view.backgroundColor = .clear
        if let footer = view.subviews.compactMap({ $0 as? LoadingFooterView }).first {
            guard canLoadMore else {
                footer.endLoading()
                return
            }
            isLoadingMore ? footer.startLoading() : footer.endLoading()
        }
    }
}

extension DetailsViewController {
    func set(question: Question) {
        self.question = question
    }
}
// MARK: - Constants

private extension TimeInterval {
    static var delay: TimeInterval { return 1 }
}

private extension CGFloat {
    static var searchTreshold: CGFloat { return 200 }
    static var footerHeight: CGFloat { return 44 }
}
