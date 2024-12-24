//
//  MovieItem.swift
//  MoviesSearch
//
//  Created by Сергей Емелин on 19.12.2024.
//

import Foundation
import SwiftyJSON

struct MovieItem {
    var title = ""
    var poster = ""
    var imdbID = ""
    
    init (json: JSON){
        if let item = json["Title"].string{
            title = item
        }
        if let item = json["Poster"].string{
            poster = item
        }
        if let item = json["imdbID"].string{
            imdbID = item
        }
    }
}
