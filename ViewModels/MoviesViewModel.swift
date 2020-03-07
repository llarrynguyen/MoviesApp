//
//  MoviesViewModel.swift
//  CueMovies
//
//  Created by Larry Nguyen on 3/5/20.
//  Copyright © 2020 Larry Nguyen. All rights reserved.
//

import Foundation


class MoviesViewModel {
    let realmDataPersistence = RealmDataPersistence()
    let apiClient = APIClient()
    var currentPage = 0
    var maxPage = 1
    var movies: [Movie] = []

    func getMovies(page: Int, completion: @escaping ([Movie]) -> ()) {
        apiClient.fetchData(endpoint: MoviesEndpoint.getMovies(page: page)) { [weak self](movies: Movies?) in
            if let movies = movies {
                self?.currentPage = movies.page
                self?.movies.append(contentsOf:movies.results)
                self?.maxPage = movies.totalPages
                self?.realmDataPersistence.store(object: movies.results, qos: .background, reduceMemoryUsage: false)
                completion(movies.results)
            } else {
                completion([])
            }
        }
    }
}
