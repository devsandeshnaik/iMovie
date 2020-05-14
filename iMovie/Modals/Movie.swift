//
//  Movie.swift
//  iMovie
//
//  Created by Sandesh on 11/05/20.
//  Copyright © 2020 sandesh. All rights reserved.
//

import Foundation
struct Movie: Codable,Hashable {
    private(set) var id: Int
    private(set) var title: String
    private(set) var overview: String
    private(set) var popularity: Double
    private(set) var vote_count: Int
    private(set) var video: Bool
    private(set) var adult: Bool
    private(set) var backdrop_path: String?
    private(set) var poster_path: String?
    private(set) var original_language: String
    private(set) var original_title: String
    private(set) var genre_ids: [Int]
    private(set) var vote_average: Double
    private(set) var release_date: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
    
}
