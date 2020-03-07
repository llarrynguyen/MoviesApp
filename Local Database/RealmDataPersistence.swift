//
//  RealmDataPersistence.swift
//  CueMovies
//
//  Created by Larry Nguyen on 3/5/20.
//  Copyright © 2020 Larry Nguyen. All rights reserved.
//

import Foundation
import RealmSwift

let realmQueue = DispatchQueue(label: "com.cuemovies.realm", qos: .background)

class RealmDataPersistence: DataSourceable {
    
    var movies: [Movie] {
        let objects = realm.objects(RMovie.self).sorted(byKeyPath: "voteAverage", ascending: false)
        
        return objects.map {
            return $0.movie
        }
    }
    
    var favoritedMovies: [Movie] {
        let objects = readFavorites()
        return objects
    }

    var realm: Realm
    
    init() {
        // Load our data
        self.realm = try! Realm()
    }
    
    
    public func store<T>(object: T, qos: DispatchQoS.QoSClass, reduceMemoryUsage: Bool = false) {
        guard let movies = object as? [Movie] else {
            return
        }
        
        DispatchQueue.global(qos: qos).async {
            autoreleasepool {
                do {
                    /// Thread safety in context current thread (just copy contact created in other thread or will be crash)
                    if reduceMemoryUsage {
                        /// Don't allocate copy of array contacts - possible reduce memory usage (but still high memory consumption on transaction)
                        let realm = try Realm()
                        realm.beginWrite()
                        for movie in movies {
                            let movieThreadSafe = RMovie(movie: movie)
                            realm.add(movieThreadSafe, update: .modified)
                        }
                        try realm.commitWrite()
                    } else {
                        var moviesThreadSafe = [RMovie]()
                        for movie in movies {
                            let movieThreadSafeCopy = RMovie(movie: movie)
                            moviesThreadSafe.append(movieThreadSafeCopy)
                        }
                        let realm = try Realm()
                        try realm.write {
                            realm.add(moviesThreadSafe, update: .modified)
                        }
                    }
                } catch let error as NSError {
                    print("Error on Realm update in different queue", error)
                }
            }
        }
    }
    
    func read(favorited: Bool) -> [Movie] {
        let realm = try! Realm()
        var movies = [Movie]()
        let rMovies = realm.objects(RMovie.self).filter("favorited == %@", favorited).sorted(byKeyPath: "voteAverage", ascending: false)
        rMovies.forEach {
            return movies.append($0.movie)
        }
        return movies
    }
    
    func readFavorites() -> [Movie] {
        let objects = read(favorited: true)
        return objects
    }
    
    func delete<T>(object: T) {
        guard let movie = object as? Movie else {
            return
        }
        
        // Delete our movie
        if let realmMovie = self.realm.object(ofType: RMovie.self, forPrimaryKey: movie.id) {
            self.realm.beginWrite()
            self.realm.delete(realmMovie)
            try? self.realm.commitWrite()
        }
    }
}

