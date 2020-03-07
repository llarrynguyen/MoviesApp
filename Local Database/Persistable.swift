//
//  Persistable.swift
//  CueMovies
//
//  Created by Larry Nguyen on 3/5/20.
//  Copyright © 2020 Larry Nguyen. All rights reserved.
//

import Foundation

protocol Persistable {
    func write(dataSource: DataSourceable)
    func delete(dataSource: DataSourceable)
}

