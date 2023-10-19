//
//  Models.swift
//  KinoBOX
//
//  Created by Sergey Savinkov on 16.10.2023.
//

import Foundation

struct SearchFilm: Codable {
    var keyword: String
    var pagesCount: Int
    var films: [FilmSerchResult]
}

struct FilmSerchResult: Codable {
    var filmId: Int
    var nameRu: String?
    var nameEn: String?
    var posterUrl: String
}

struct TopResult: Codable {
    var pagesCount: Int
    var films: [TopRating]
}

struct TopRating: Codable {
    var filmId: Int
    var nameRu: String?
    var nameEn: String?
    var posterUrl: String
}

struct IdFilmSerchResult: Codable {
    var kinopoiskId: Int
    var nameRu: String?
    var nameEn: String?
    var description: String?
    var year: Int
    var filmLength: Int
    var ratingKinopoisk: Double
    var ratingImdb: Double
    var posterUrl: String
}
