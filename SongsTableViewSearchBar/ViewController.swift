//
//  ViewController.swift
//  SongsTableViewSearchBar
//
//  Created by C4Q  on 11/6/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var music: UITableView!
    
    let allSongs = Song.loveSongs
    
    var searchResult:[Song] {
        get {
            
            //when we have no search term, return the value of the initial set of people
            guard let searchString = searchString else {
                return allSongs
            }
            guard searchString != ""  else {
                return allSongs
            }
            if let scopeTitles = searchBar.scopeButtonTitles {
                let currentScopeIndex = searchBar.selectedScopeButtonIndex
                switch scopeTitles[currentScopeIndex] {
                case "Songs":
                    return allSongs.filter{$0.name.contains(searchString.lowercased())}
                case "Artists":
                    return allSongs.filter{$0.artist.contains(searchString.lowercased())}
                default:
                    return allSongs
                }
            }
            return allSongs
        }
    }
    
    var searchString: String? = nil {
        didSet {
//            print(searchString)
            self.music.reloadData()
        }
    }


    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loding the view, typically from a nib.
        music.dataSource = self
        searchBar.delegate = self
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = music.dequeueReusableCell(withIdentifier: "songListCell", for: indexPath) as? InfoCell{
        
        //add song name
//        cell.textLabel?.text = allSongs[indexPath.row].name
//        //add artist name
//        cell.detailTextLabel?.text = allSongs[ indexPath.row].artist
            
            cell.songTitle.text = allSongs[indexPath.row].name
            //add artist name
            cell.artist.text = allSongs[ indexPath.row].artist
            return cell
            
        }
        return UITableViewCell()

    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchBar.text
    }
}
