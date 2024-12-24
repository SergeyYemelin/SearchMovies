//
//  MoviesTableViewCell.swift
//  MoviesSearch
//
//  Created by Сергей Емелин on 19.12.2024.
//

import UIKit
import SDWebImage

class MoviesTableViewCell: UITableViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(movie: MovieItem){
        titleLabel.text = movie.title
        
        posterImageView.sd_setImage(with: URL(string: movie.poster))
       
    }

}
