//
//  SearchMoviesTableViewController.swift
//  MoviesSearch
//
//  Created by Сергей Емелин on 19.12.2024.

// ссылка на документацию API https://www.omdbapi.com
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class SearchMoviesTableViewController: UITableViewController, UISearchBarDelegate {
    
    var arrayMovies = [MovieItem]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        let search = UISearchController()
        search.searchBar.delegate = self
        
        search.searchBar.placeholder = "Search movie"
        
        navigationItem.searchController = search
        
    }

    func searchMovies(s: String) {
        SVProgressHUD.show()
        
        let parameters = ["s": s, "apikey": "1a0c4e22", "page": "1", "type" : "movie"]
               
               AF.request("https://www.omdbapi.com/?", method: .get, parameters: parameters).responseData { response in
                   SVProgressHUD.dismiss()
            
            if response.response?.statusCode == 200 {
                
                let json = JSON(response.data!)
                
                if let array = json["Search"].array {
                    for item in array {
                        let movie = MovieItem(json: item)
                        
                        self.arrayMovies.append(movie)
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        arrayMovies.removeAll()
        tableView.reloadData()
        
        searchMovies(s: searchBar.text!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showViewController",
           let detailsVC = segue.destination as? ViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            let selectedMovie = arrayMovies[indexPath.row]
            detailsVC.imdbID = selectedMovie.imdbID
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayMovies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MoviesTableViewCell
        

        cell.setData(movie: arrayMovies[indexPath.row])
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
