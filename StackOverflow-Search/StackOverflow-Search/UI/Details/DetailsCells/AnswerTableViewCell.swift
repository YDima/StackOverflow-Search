//
//  AnswerTableViewCell.swift
//  StackOverflow-Search
//
//  Created by Aliona Starunska on 25.02.2021.
//

import UIKit

class AnswerTableViewCell: UITableViewCell, ReusableCell, ConfigurableCell {

    @IBOutlet private weak var textAnswerTable: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var trueAnswerImageView: UIImageView!
    @IBOutlet private weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with data: Answer?) {
        textAnswerTable?.attributedText = data?.description.htmlAttributedString()
        nameLabel.text = data?.owner.nickname?.decoded
        avatarImageView.url = data?.owner.profileImageURL
        trueAnswerImageView.image = data?.isAccepted == true ? Asset.Assets.trueIcon.image: nil
        scoreLabel.text = "\(data?.numberOfVotes ?? 0 )"
        
    }
}
