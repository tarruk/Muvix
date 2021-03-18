//
//  PreviewTableViewCell.swift
//  MoviesApp
//
//  Created by Tarek on 12/03/2021.
//

import UIKit

class PreviewTableViewCell: UITableViewCell {

  
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var categoryLabelContainer: UIView!
    @IBOutlet weak var categoryLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = Colors.backgroundBlack
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func configureCell(with movie: MovieDB) {
        
        if let name = movie.title {
            movieNameLabel.configure(
                text: name,
                color: .white,
                font: Fonts.SwanSea.bold.sized(24),
                shadowColor: .black
            )
        } else {
            movieNameLabel.configure(
                text: "",
                color: .white,
                font: Fonts.SwanSea.bold.sized(24)
            )
        }
        
        
        
        if let image = movie.posterPath {
            self.movieImage.getImage(from: image)
            self.movieImage.contentMode = .scaleAspectFill
        } else {
            self.movieImage.image = #imageLiteral(resourceName: "moviePlaceholder 1")
            self.movieImage.contentMode = .center
            self.movieImage.tintColor = .white
        }
        movieImage.radius(3)
        
        if let genre = movie.selectedGenre {
            categoryLabel.configure(
                text: genre.uppercased(),
                color: .white,
                font: Fonts.SwanSea.regular.sized(12)
            )
        }
        
        categoryLabelContainer.configUI(
            backgroundColor: Colors.backgroundDark,
            alpha: 0.8,
            borderRadius: 3
        )
       
    }
    
}

