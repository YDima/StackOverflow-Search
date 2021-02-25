import UIKit

class LoadingFooterView: UIView {

    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var activityView: UIActivityIndicatorView!
    
    // MARK: - Lifecycle

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Public
    
    func startLoading() {
        textLabel.isHidden = false
        activityView.startAnimating()
    }
    
    func endLoading() {
        textLabel.isHidden = true
        activityView.stopAnimating()
    }
}
