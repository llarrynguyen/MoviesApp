//
//  MovieCell.swift
//  CueMovies
//
//  Created by Larry Nguyen on 3/5/20.
//  Copyright © 2020 Larry Nguyen. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    static let identifier = "MovieCell"
    var showShowFullAlwaysHeart = false

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         
    }
    
    var likeActionClosure: VoidClosure?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = ""
        ratingLabel.text = ""
    }
    
    func updateCell(_ movie: Movie) {
        if movie.favorited == true {
            likeButton.setImage(UIImage(named:"icons8-like_filled"), for: .normal)
        }
        if let posterPath = movie.posterPath {
            let urlString = Domain.imageDomain.rawValue + posterPath
            imageView.downloadImage(urlString: urlString)
        }
        titleLabel.text = movie.title
        ratingLabel.text = "Rating: \(movie.voteAverage ?? 0.0)"
    }
    
    func updateFavorite(_ favorited: Bool) {
        let image = favorited ? UIImage(named:"icons8-like_filled") : UIImage(named:"icons8-like")
        likeButton.setImage(image, for: .normal)
        layoutSubviews()
    }
    @IBAction func likeTapped(_ sender: Any) {
        likeActionClosure?()
    }
}
