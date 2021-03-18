//
//  SubscribedMoviesTableViewCell.swift
//  MoviesApp
//
//  Created by Tarek on 13/03/2021.
//

import UIKit


protocol SubscribedMoviesTableViewCellDelegate: class {
    func openMovieDetail(with index: Int)
}

class SubscribedMoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var subscribedMovies: [MovieDB] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    weak var delegate: SubscribedMoviesTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = Colors.backgroundBlack
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCell(with movies: [MovieDB], delegate: SubscribedMoviesTableViewCellDelegate) {
        self.delegate = delegate
        collectionView
            .setup(
                delegate: self,
                dataSource: self,
                cells: [SubscribedMovieCollectionViewCell.self]
            )
        self.subscribedMovies = movies
    }
    
}


extension SubscribedMoviesTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
  
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.openMovieDetail(with: indexPath.row)
    }
    
    
    
}
