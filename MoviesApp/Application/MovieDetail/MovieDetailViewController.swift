//
//  MovieDetailViewController.swift
//  MoviesApp
//
//  Created by Tarek on 13/03/2021.
//

import UIKit

class MovieDetailViewController: BaseViewController {


    @IBOutlet weak var subscriptionButtonTop: NSLayoutConstraint!
    @IBOutlet weak var imageStackView: UIStackView!
    @IBOutlet weak var overviewTitleLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var subscriptionButton: UIButton!
    @IBOutlet weak var movieDateLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var imageStackTop: NSLayoutConstraint!
    @IBOutlet weak var movieImageHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var movieImage: UIImageView!
    
    var currentMovie: Movie
    var initialImageViewHeight: CGFloat?
    
    init(movie: Movie) {
        self.currentMovie = movie
        super.init()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetup()
        configureViews()
        if let imageURL = currentMovie._imageURL {
            backgroundImage.getImage(from: imageURL)
            movieImage.getImage(from: imageURL)
            colorView.backgroundColor = self.movieImage.image?.averageColor
            self.movieImage.radius(3)
        }
        configureScrollView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initialImageViewHeight = movieImageHeight.constant
    }
   
    func navigationBarSetup() {
        let leftBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "back_icon"), style: .plain, target: self, action: #selector(popViewController))
        leftBarButton.image?.withRenderingMode(.alwaysOriginal)
        configNav(leftButton: leftBarButton)
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    
    @objc func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func configureViews() {
        if let movieName = currentMovie.orgTitle {
            self.movieTitleLabel.configure(
                text: movieName.capitalized,
                color: .white,
                font: Fonts.SwanSea.bold.sized(24)
            )
        }
        
        if let movieDate = currentMovie.releaseDate {
            self.movieDateLabel.configure(
                text: movieDate,
                color: .white,
                font: Fonts.SwanSea.regular.sized(16)
            )
        }
        
        subscriptionButton.unselectedCustom(title: "subscribirme")
        
        overviewTitleLabel.configure(text: "OVERVIEW", color: .black, font: Fonts.SwanSea.bold.sized(14))
        
        if let movieDescription = currentMovie.description {
            self.movieDescriptionLabel.configure(
                text: movieDescription,
                color: .white,
                font: Fonts.SwanSea.regular.sized(14)
            )
    
        }
        
    }
    
    func configureScrollView(){
        scrollView.delegate = self
        scrollView.contentInset = UIEdgeInsets(
            top: self.imageStackView.frame.height + self.imageStackTop.constant  ,
            left: 0,
            bottom: 0,
            right: 0
        )
    }
    

}


extension MovieDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let initialImageViewHeight = self.initialImageViewHeight else {
            return
        }
        let initialTopOffset = scrollView.contentInset.top
        let normalizedContentOffset = scrollView.contentOffset.y + initialTopOffset
        print(normalizedContentOffset)
        if normalizedContentOffset > 0 {
            imageStackTop.constant = -normalizedContentOffset * 0.3
            movieImageHeight.constant = initialImageViewHeight - normalizedContentOffset
           
            if movieImageHeight.constant <= 140 {
                UIView.animate(withDuration: 1) {
                    self.movieImage.alpha = 0
                    self.imageStackTop.constant = -40
                    self.subscriptionButtonTop.constant = normalizedContentOffset * 0.3
                }
            } else {
                UIView.animate(withDuration: 1) {
                    self.movieImage.alpha = 1
                }
            }
        } else {
          
            movieImageHeight.constant = initialImageViewHeight - normalizedContentOffset
        }
        
        
        
    }
}
