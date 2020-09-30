//
//  ImageCell.swift
//  Pryaniki
//
//  Created by Admin on 30.09.2020.
//  Copyright © 2020 Danil Semenov. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {

    static let identifier = "ImageCell"
    static let nib = UINib(nibName: "ImageCell", bundle: nil)
    
    @IBOutlet weak var pictureImageView: UIImageView!
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
        guard
            let data = item.asPictureItem(),
            let imageUrl = URL(string: data.url),
            let imageData = try? Data(contentsOf: imageUrl) else { return }
        descriptionLabel.text = "\(data.text)"
        pictureImageView.image = UIImage(data: imageData)
    }
}
