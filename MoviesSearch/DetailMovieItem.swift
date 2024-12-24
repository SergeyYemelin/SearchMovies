//
//  DetailMovieItem.swift
//  MoviesSearch
//
//  Created by Сергей Емелин on 23.12.2024.
//

import Foundation
import SwiftyJSON

struct DetailMovieItem {
    var title = ""
    var year = ""
    var runtime = ""
    var genre = ""
    var director = ""
    var poster = ""
    var actors = ""
    
    init(json: [String: JSON]) {
        if let item = json["Title"]?.string{
            title = item
        }
        if let item = json["Year"]?.string{
            year = item
        }
        if let item = json["Runtime"]?.string{
            runtime = item
        }
        if let item = json["Genre"]?.string{
            genre = item
        }
        if let item = json["Director"]?.string{
            director = item
        }
        if let item = json["Poster"]?.string{
            poster = item
        }
        if let item = json["Actors"]?.string{
            actors = item
        }
    }
}
