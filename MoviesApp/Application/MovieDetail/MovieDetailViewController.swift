//
//  MovieDetailViewController.swift
//  MoviesApp
//
//  Created by Tarek on 13/03/2021.
//

import UIKit

class MovieDetailViewController: BaseViewController {


    @IBOutlet weak var buttonTopLimit: NSLayoutConstraint!
    @IBOutlet weak var imageStackContainerTop: NSLayoutConstraint!
    @IBOutlet weak var imageStackContainer: UIView!
    @IBOutlet weak var subscriptionButtonTop: NSLayoutConstraint!
    @IBOutlet weak var imageStackView: UIStackView!
    @IBOutlet weak var overviewTitleLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var subscriptionButton: UIButton!
    @IBOutlet weak var movieDateLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var movieImageHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var movieImage: UIImageView!
    
    var viewModel: MovieDetailViewModel
    var initialImageViewHeight: CGFloat?
  
    
    init(movie: MovieDB) {
    
        self.viewModel  = MovieDetailViewModel(movie: movie)
        super.init()
        
    }
    
    deinit {
        debugPrint("Closing MovieDetail")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetup()
        observerSetup()
        configureScrollView()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
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
    
    func observerSetup() {
        viewModel.movieImageUrl.distinctUntilChanged()
            .subscribe(
                onNext: { [weak self] imageURL in
                    guard let self = self,
                          let imageURL = imageURL else {return}
                    self.backgroundImage.getImage(from: imageURL)
                    self.movieImage.getImage(from: imageURL)
                    self.colorView.backgroundColor = self.movieImage.image?.averageColor
                    self.movieImage.radius(6)
                }).disposed(by: disposeBag)
      
        viewModel.movieTitle.distinctUntilChanged()
            .subscribe(
                onNext: { [weak self] movieTitle in
                    guard let self = self,
                          let movieTitle = movieTitle else {return}
                    self.movieTitleLabel.configure(
                        text: movieTitle,
                        color: .white,
                        font: Fonts.SwanSea.bold.sized(24),
                        shadowColor: .black
                    )
                   
                }).disposed(by: disposeBag)
        
        viewModel.movieOverview.distinctUntilChanged()
            .subscribe(
                onNext: { [weak self] movieOverview in
                    guard let self = self,
                          let movieOverview = movieOverview else {return}
                    self.movieDescriptionLabel.configure(
                        text: movieOverview,
                        color: .white,
                        font: Fonts.SwanSea.regular.sized(14),
                        shadowColor: .black
                    )
                }).disposed(by: disposeBag)
        
        viewModel.movieReleaseDate.distinctUntilChanged()
            .subscribe(
                onNext: { [weak self] movieReleaseDate in
                    guard let self = self,
                          let movieReleaseDate = movieReleaseDate else {return}
                    self.movieDateLabel.configure(
                        text: movieReleaseDate,
                        color: .white,
                        font: Fonts.SwanSea.regular.sized(16),
                        shadowColor: .black
                    )
                }).disposed(by: disposeBag)
       
        
        
        overviewTitleLabel.configure(text: "OVERVIEW", color: .black, font: Fonts.SwanSea.bold.sized(14))
        
        viewModel.movieSubscription
            .subscribe(
                onNext: { [weak self] subscription in
                    guard let self = self else {return}
                    subscription ? self.subscriptionButton.subscribedCustom(titleColor: self.colorView.backgroundColor ?? .black, alpha: 0.60) : self.subscriptionButton.unsubscribedCustom()
                }).disposed(by: disposeBag)
        
    }
    
    func configureScrollView(){
        scrollView.delegate = self
        
        scrollView.contentInset = UIEdgeInsets(
            top: self.imageStackContainer.frame.height,
            left: 0,
            bottom: 0,
            right: 0
        )
    }
    
    @IBAction func subscribe(_ sender: Any) {
        viewModel.subscribeButtonPressed()
    }
    
}


//MARK: - Scroll Animations -
extension MovieDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.buttonTopLimit.constant = self.imageStackContainer.frame.height
        guard let initialImageViewHeight = self.initialImageViewHeight else {
            return
        }
        let initialTopOffset = scrollView.contentInset.top
        let normalizedContentOffset = scrollView.contentOffset.y + initialTopOffset
        print(normalizedContentOffset)
        
        if normalizedContentOffset > 0 {
            imageStackContainerTop.constant = -normalizedContentOffset * 0.3
            movieImageHeight.constant = initialImageViewHeight - normalizedContentOffset
            
            if movieImageHeight.constant <= 10 {
                UIView.animate(withDuration: 1) {
                    self.movieImage.alpha = 0
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
