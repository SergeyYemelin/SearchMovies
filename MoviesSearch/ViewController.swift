//
//  ViewController.swift
//  MoviesSearch
//
//  Created by Сергей Емелин on 19.12.2024.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    
    var imdbID = ""
    var movieDetail: DetailMovieItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        
        let parameters = ["i": imdbID, "apikey": "1a0c4e22"]
        
        AF.request("https://www.omdbapi.com/", method: .get, parameters: parameters).responseData { response in
            SVProgressHUD.dismiss()
            
            if response.response?.statusCode == 200 {
                 
                let json = JSON(response.data!)
                
                if let movieData = json.dictionary {
                    
                    self.movieDetail = DetailMovieItem(json: movieData)
                    
                    self.showDetail()
                }
            }
        }
    }
    
    func showDetail() {
        if let movie = movieDetail {
            
            titlelabel.text = movie.title
            yearLabel.text = "Year: " + movie.year
            runtimeLabel.text = "Runtime: " + movie.runtime
            genreLabel.text = "Genre: " + movie.genre
            directorLabel.text = "Director: " + movie.director
            actorsLabel.text = "Actors: " + movie.actors
            posterImageView.sd_setImage(with: URL(string: movie.poster))
        }
    }
}
