//
//  MoviesViewController.swift
//  CueMovies
//
//  Created by Larry Nguyen on 3/5/20.
//  Copyright © 2020 Larry Nguyen. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = MoviesViewModel()
    
    var loading: Bool = false
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: screenWidth/2 - 32 , height: screenHeight/3)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadPlayingMovies()
    }
    

    private func loadPlayingMovies(){
        let pageToLoad = viewModel.currentPage + 1
        print(pageToLoad)
        if pageToLoad > viewModel.maxPage {
            return
        }
        loading = true
        viewModel.getMovies(page: pageToLoad) { [weak self] movies in
            mainQueue {
                self?.collectionView.reloadData()
                self?.loading = false
            }
        }
    }

    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.register(UINib(nibName: MovieCell.identifier, bundle: nil), forCellWithReuseIdentifier: MovieCell.identifier)
    }
}

extension MoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell {
            cell.updateCell(viewModel.movies[indexPath.row])
            cell.likeActionClosure = {[weak self] in
                guard let movie = self?.viewModel.movies[indexPath.row] else {return}
                let newLikeStatus = !(movie.favorited ?? false)
                movie.favorited = newLikeStatus
                cell.updateFavorite(newLikeStatus)
                self?.viewModel.realmDataPersistence.store(object: [movie], qos: .background, reduceMemoryUsage: false)
            }
            return cell
        }
        return UICollectionViewCell()
    }
}

extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row >= viewModel.movies.count - 3 {
            if loading == false {
                 loadPlayingMovies()
            }
           
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController {
            detailVC.movie = viewModel.movies[indexPath.row]
            present(detailVC, animated: true, completion: nil)
        }
    }
}
