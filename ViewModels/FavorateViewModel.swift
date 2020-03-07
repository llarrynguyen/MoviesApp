//
//  FavorateViewModel.swift
//  CueMovies
//
//  Created by Larry Nguyen on 3/5/20.
//  Copyright © 2020 Larry Nguyen. All rights reserved.
//

import Foundation

class FavorateViewModel {
    let realmDataPersistence = RealmDataPersistence()
    
    var favoriteMovies: [Movie] {
        get {
            return realmDataPersistence.favoritedMovies
        }
    }
}
