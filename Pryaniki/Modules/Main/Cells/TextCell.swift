//
//  TextCell.swift
//  Pryaniki
//
//  Created by Admin on 30.09.2020.
//  Copyright © 2020 Danil Semenov. All rights reserved.
//

import UIKit

class TextCell: UITableViewCell {

    static let identifier = "TextCell"
    static let nib = UINib(nibName: "TextCell", bundle: nil)
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with item: PryanikItem) {
        guard let data = item.asHzItem() else { return }
        descriptionLabel.text = "\(data.name)"
    }
}
