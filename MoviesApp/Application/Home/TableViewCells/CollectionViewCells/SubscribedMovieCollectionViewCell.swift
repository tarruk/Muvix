//
//  SubscribedMovieCollectionViewCell.swift
//  MoviesApp
//
//  Created by Tarek on 13/03/2021.
//

import UIKit

class SubscribedMovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(with movie: Movie) {
        if let image = movie.posterPath {
            self.movieImage.getImage(from: "https://image.tmdb.org/t/p/w500/\(image)")
            self.movieImage.contentMode = .scaleAspectFill
        } else {
            self.movieImage.image = #imageLiteral(resourceName: "moviePlaceholder 1")
            self.movieImage.contentMode = .center
            self.movieImage.tintColor = .white
        }
        movieImage.radius(3)
    }
    
}
