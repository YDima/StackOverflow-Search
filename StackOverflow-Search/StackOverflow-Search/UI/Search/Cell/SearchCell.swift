//
//  SearchCell.swift
//  StackOverflow-Search
//
//  Created by Aliona Starunska on 25.02.2021.
//

import UIKit

class SearchCell: UITableViewCell, ReusableCell, ConfigurableCell {

    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private weak var answeredImageView: UIImageView!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with data: Question?) {
        questionLabel.text = data?.title?.decoded
        answeredImageView.image = data?.isAnswered == true ? Asset.Assets.trueIcon.image: Asset.Assets.falseIcon.image
        avatarImageView.url = data?.owner?.profileImageURL
        nameLabel.text = data?.owner?.nickname
        dateLabel.text = data?.date?.timeString
    }
}
