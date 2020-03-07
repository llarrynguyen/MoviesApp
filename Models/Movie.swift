//
//  Movie.swift
//  CueMovies
//
//  Created by Larry Nguyen on 3/5/20.
//  Copyright © 2020 Larry Nguyen. All rights reserved.
//

import Foundation

class Movie: Decodable {
    let id: Int
    let title: String?
    let posterPath: String?
    let voteAverage: Double?
    var favorited: Bool?
    
    init(
        id: Int,
        title: String,
        posterPath: String, voteAverage: Double , favorited: Bool = false) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.voteAverage = voteAverage
        self.favorited = favorited
    }
}

class Movies: Decodable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
}

extension Movie: Persistable {
    
    func write(dataSource: DataSourceable) {
        dataSource.store(object: [self], qos: .background, reduceMemoryUsage: false)
    }
    
    func delete(dataSource: DataSourceable) {
        dataSource.delete(object: [self])
    }
}

extension Movie {
    convenience init(realmMovie: RMovie) {
        self.init(
            id: realmMovie.id,
            title: realmMovie.title,
            posterPath: realmMovie.posterPath, voteAverage: realmMovie.voteAverage , favorited: realmMovie.favorited)
    }
    
    var realmMovie: RMovie {
        return RMovie(movie: self)
    }
}

