//
//  SubscribedMoviesTableViewCell.swift
//  MoviesApp
//
//  Created by Tarek on 13/03/2021.
//

import UIKit

class SubscribedMoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = Colors.backgroundBlack
    }

    var subscribedMovies: [Movie] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCell(with movies: [Movie]) {
        collectionViewSetup()
        self.subscribedMovies = movies
    }
    
}


extension SubscribedMoviesTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionViewSetup() {
        collectionView.dataSource   = self
        collectionView.delegate     = self
        
        collectionView.register(UINib(nibName: "SubscribedMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SubscribedMovieCollectionViewCell")
        
        collectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.subscribedMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let subscribedMovieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubscribedMovieCollectionViewCell", for: indexPath) as! SubscribedMovieCollectionViewCell
        subscribedMovieCell.configureCell(with: subscribedMovies[indexPath.row])
        return subscribedMovieCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let ratioFactor: CGFloat = 1/1.5
        return CGSize(width: collectionView.frame.height * ratioFactor, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
}
