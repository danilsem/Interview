//
//  SelectorCell.swift
//  Pryaniki
//
//  Created by Admin on 30.09.2020.
//  Copyright © 2020 Danil Semenov. All rights reserved.
//

import UIKit

class SelectorCell: UITableViewCell {

    static let identifier = "SelectorCell"
    static let nib = UINib(nibName: "SelectorCell", bundle: nil)
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with item: PryanikItem) {
        guard let data = item.asSelectorItem() else { return }
        for selectorItem in data.variants {
            let label = UILabel()
            label.text = "\(selectorItem.text)"
            if data.selected == selectorItem.id {
                label.font = .boldSystemFont(ofSize: 17)
            }
            stackView.addArrangedSubview(label)
        }
    }
    
}
