//
//  QuestionTableViewCell.swift
//  StackOverflow-Search
//
//  Created by Aliona Starunska on 24.02.2021.
//

import UIKit

class QuestionTableViewCell: UITableViewCell, ReusableCell, ConfigurableCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with data: Question?) {
        
    }
    
}
