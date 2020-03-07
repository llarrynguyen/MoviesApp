//
//  DataSourceable.swift
//  CueMovies
//
//  Created by Larry Nguyen on 3/5/20.
//  Copyright © 2020 Larry Nguyen. All rights reserved.
//


import Foundation

protocol DataSourceable {
    func store<T>(object: T, qos: DispatchQoS.QoSClass, reduceMemoryUsage: Bool)
    func delete<T>(object: T)
}
