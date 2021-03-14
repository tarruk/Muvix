//
//  MovieTableViewCell.swift
//  MoviesApp
//
//  Created by Tarek on 14/03/2021.
//

import UIKit


protocol MovieTableViewCellDelegate: class {
    func addButtonPressed(at cell: UITableViewCell)
}

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var addMovieButton: UIButton!
    
    
    
    weak var delegate: MovieTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = Colors.backgroundBlack
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(movie: Movie, delegate: MovieTableViewCellDelegate) {
        self.delegate = delegate
        
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
        
        movie._added ? addMovieButton.addedCustom(title: "Agregado", titleColor: Colors.backgroundBlack) : addMovieButton.noAddedCustom(title: "agregar")
        
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
        delegate?.addButtonPressed(at: self)
        
    }
    
    
    
}
