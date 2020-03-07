//
//  MovieDetailViewController.swift
//  CueMovies
//
//  Created by Larry Nguyen on 3/5/20.
//  Copyright © 2020 Larry Nguyen. All rights reserved.
//

import UIKit

class MovieDetailViewController : UIViewController{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var votingLabel: UILabel!
    
    var movie: Movie? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie {
            if let posterPath = movie.posterPath {
                 let urlString = Domain.imageDomain.rawValue + posterPath
                 imageView.downloadImage(urlString: urlString)
            } else {
                imageView.image = UIImage(named: "placeholder-movieimage")
            }
           
           
            titleLabel.text = movie.title
            votingLabel.text = "Voting average is \(movie.voteAverage ?? 0.0)"
        }
        
    }
    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
