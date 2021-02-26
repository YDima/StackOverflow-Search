//
//  QuestionTableViewCell.swift
//  StackOverflow-Search
//
//  Created by Aliona Starunska on 24.02.2021.
//

import UIKit

class QuestionTableViewCell: UITableViewCell, ReusableCell, ConfigurableCell {
    @IBOutlet private weak var questionTitleLabel: UILabel!
    @IBOutlet private weak var answeredImageView: UIImageView!
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with data: Question?) {
        questionTitleLabel.text = data?.title?.decoded
        questionLabel.text = data?.body?.decoded
        answeredImageView.image = data?.isAnswered == true ? Asset.Assets.trueIcon.image: Asset.Assets.falseIcon.image
        avatarImageView.url = data?.owner?.profileImageURL
        nameLabel.text = data?.owner?.nickname?.decoded
        dateLabel.text = data?.date?.timeString
    }
    
}
