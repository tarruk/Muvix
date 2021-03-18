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
    

    var movie: MovieDB?
    var onSubscribe: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = Colors.backgroundBlack
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(movie: MovieDB, onSubscribe: @escaping (()->Void)) {
        self.movie = movie
        self.onSubscribe = onSubscribe
        self.lineView.backgroundColor = Colors.lineGray
        
        if let name = movie.title {
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
        
        movie.subscribed ? subscribeButton.subscribedCustom(titleColor: Colors.backgroundBlack, radius: 3, alpha: 0.30) : subscribeButton.unsubscribedCustom(radius: 3, alpha: 0.30)
        
        if let image = movie.posterPath{
            self.movieImage.getImage(from: image)
            self.movieImage.contentMode = .scaleAspectFill
        } else {
            self.movieImage.image = #imageLiteral(resourceName: "moviePlaceholder 1")
            self.movieImage.contentMode = .center
            self.movieImage.tintColor = .white
        }
        movieImage.radius(3)
        
        if let genre = movie.selectedGenre {
            movieGenreLabel.configure(
                text: genre.uppercased(),
                color: .white,
                font: Fonts.SwanSea.regular.sized(12)
            )
        }
    
    }
    
    
    @IBAction func addMovie(_ sender: Any) {
        self.movie?.subscribed.toggle()
        self.onSubscribe?()
    }
    
    
    
}
