//
//  RMovie.swift
//  CueMovies
//
//  Created by Larry Nguyen on 3/5/20.
//  Copyright © 2020 Larry Nguyen. All rights reserved.
//

import Foundation
import RealmSwift

class RMovie: Object {

    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var posterPath: String = ""
    @objc dynamic var voteAverage: Double = 0.0
    @objc dynamic var favorited: Bool = false

    override class func primaryKey() -> String? {
        return "id"
    }
    
}

extension RMovie {
    
    convenience init(movie: Movie) {
        self.init()
        
        self.id = movie.id
        self.title = movie.title ?? ""
        self.posterPath = movie.posterPath ?? ""
        self.voteAverage = movie.voteAverage ?? 0.0
        self.favorited = movie.favorited ?? false
    }
    
    var movie: Movie {
        return Movie(realmMovie: self)
    }
}
