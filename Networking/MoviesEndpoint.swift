//
//  MoviesEndpoint.swift
//  CueMovies
//
//  Created by Larry Nguyen on 3/4/20.
//  Copyright © 2020 Larry Nguyen. All rights reserved.
//

import Foundation

enum  MoviesEndpoint {
    case getMovies(page: Int)
    static let apiKey = "1e1c266b3ca81dad5aea7386cd74c596"
}

extension  MoviesEndpoint : EndpointProtocol {
    var baseUrl: String {
        return Domain.movieDomain.rawValue
    }
    
    var path: String {
        switch self {
            case .getMovies:
                return "/3/movie/now_playing"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
            case .getMovies:
                return .get
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
            case .getMovies(let page):
                return [
                    URLQueryItem(name: "api_key", value: MoviesEndpoint.apiKey),
                    URLQueryItem(name: "page", value: "\(page)")
            ]
        }
    }
    
    var request: URLRequest? {
        var urlComponents = URLComponents(string: baseUrl)
        urlComponents?.path = path
        urlComponents?.queryItems = parameters
        if let url = urlComponents?.url {
            var request = URLRequest(url: url)
            request.httpMethod = httpMethod.rawValue
            request.allHTTPHeaderFields = headers
            return request
        }
        return nil
    }
    
    var headers: HTTPHeaders? {
        return [
            "Content-Type" : "application/json"
        ]
    }
}

