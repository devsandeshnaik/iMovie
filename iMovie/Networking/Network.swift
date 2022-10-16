//
//  Network.swift
//  iMovie
//
//  Created by Sandesh on 11/05/20.
//  Copyright © 2020 sandesh. All rights reserved.
//

import Foundation

enum ApiError: Error {
    case invalidURL
}

enum MediaTypes: String {
    case movie
    case tv
}

enum TrendingPeriod: String {
    case day
    case week
}

enum MovieApiEndPoint {
    case nowPlaying
    case topRated
    case upcoming
    case popular
    case trending(MediaTypes, TrendingPeriod)
    
    var key: String {
        switch self {
        case .nowPlaying: return "now_playing"
        case .topRated: return "top_rated"
        case .upcoming: return "upcoming"
        case .popular: return "popular"
        case .trending: return "trending"
        }
    }
    
    var apiURL: String {
        switch self {
        case .trending(let media, let period):
            return NetworkConstants.baseURL
            + key
            + "/\(media.rawValue)"
            + "/\(period.rawValue)"
            + NetworkConstants.apiKeyString
        default:
            return NetworkConstants.baseURL + "movie/" + key + NetworkConstants.apiKeyString
        }
    }
    
}

class ApiRequset {
        
    static let shared = ApiRequset()
    private init () { }
    //TODO: - Generate URLRequest
    func getMovie(api endPoint: MovieApiEndPoint, handler: @escaping ([Movie]) -> ()) {
        let urlString  = endPoint.apiURL
        make(urlString) { data, response, error in
            if data != nil {
                let jsonDecoder = JSONDecoder()
                do {
                    let movies = try jsonDecoder.decode(NowPlaying.self, from: data!)
                    handler(movies.results)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getMediaImage(named: String, handler: @escaping (Data?) -> ()) {
        make(NetworkConstants.imageURl + named) { data, response, error in
            handler(data)
        }
    }
    
    private func make(_ request: String,handler: @escaping (Data? , URLResponse?, Error?) -> () ){
        guard let url = URL(string: request) else { return }
        let session = URLSession.shared
        let request = URLRequest(url: url)
        session.dataTask(with: request) { handler($0,$1,$2) }.resume()
    }
}
