//
//  MovieTableViewCell.swift
//  MoviesApp
//
//  Created by Tarek on 14/03/2021.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var subscribeButton: UIButton!
    

    var movie: Movie?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = Colors.backgroundBlack
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(movie: Movie) {
        self.movie = movie
        self.lineView.backgroundColor = Colors.lineGray
        
        if let name = movie.orgTitle {
            movieTitleLabel.configure(
                text: name,
                color: .white,
                font: Fonts.SwanSea.bold.sized(18)
            )
        } else {
            movieTitleLabel.configure(
                text: "",
                color: .white,
                font: Fonts.SwanSea.bold.sized(24)
            )
        }
        
        movie._subscribed ? subscribeButton.subscribedCustom(titleColor: Colors.backgroundBlack, radius: 3, alpha: 0.30) : subscribeButton.unsubscribedCustom(radius: 3, alpha: 0.30)
        
        if let image = movie._imageURL {
            self.movieImage.getImage(from: image)
            self.movieImage.contentMode = .scaleAspectFill
        } else {
            self.movieImage.image = #imageLiteral(resourceName: "moviePlaceholder 1")
            self.movieImage.contentMode = .center
            self.movieImage.tintColor = .white
        }
        movieImage.radius(3)
        
        if let genre = movie._selectedGenre?.name {
            movieGenreLabel.configure(
                text: genre.uppercased(),
                color: .white,
                font: Fonts.SwanSea.regular.sized(12)
            )
        }
    
    }
    
    
    @IBAction func addMovie(_ sender: Any) {
        self.movie?._subscribed.toggle()
        NotificationCenter.default.post(name: .updateSubscribedMovies, object: nil)
        
    }
    
    
    
}
