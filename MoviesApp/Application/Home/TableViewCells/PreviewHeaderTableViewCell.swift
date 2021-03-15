//
//  PreviewHeaderTableViewCell.swift
//  MoviesApp
//
//  Created by Tarek on 13/03/2021.
//

import UIKit

class PreviewHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = Colors.backgroundBlack
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureHeader(with title: String) {
        self.titleLabel.configure(
            text: title,
            color: .white,
            font: Fonts.SwanSea.regular.sized(12),
            alpha: 0.56
        )
    }
    
}
