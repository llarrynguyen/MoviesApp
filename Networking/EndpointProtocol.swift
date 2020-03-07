//
//  EndpointProtocol.swift
//  CueMovies
//
//  Created by Larry Nguyen on 3/4/20.
//  Copyright © 2020 Larry Nguyen. All rights reserved.
//

import Foundation

typealias HTTPHeaders = [String: String]

protocol EndpointProtocol {
    var baseUrl : String { get }
    var path: String { get }
    var httpMethod : HTTPMethod { get }
    var parameters : [URLQueryItem]? { get }
    var request: URLRequest? { get }
    var headers: HTTPHeaders? { get}
}

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
    case post = "POST"
}

enum Domain: String {
    case movieDomain = "https://api.themoviedb.org"
    case imageDomain = "http://image.tmdb.org/t/p/w200" // assume the fixed size image
}
