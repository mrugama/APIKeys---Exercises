//
//  ArtistViewController.swift
//  APIKeys - Exercises
//
//  Created by C4Q on 12/4/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class ArtistViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var artists = [Artist]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    var searchTerm = "" {
        didSet {
            loadArtist(named: searchTerm)
        }
    }
    
    func loadArtist(named str: String) {
        let setArtists = {(onlineArtists: [Artist]) in
            self.artists = onlineArtists
        }
        let printErrors = {(error: Error) in
            print(error)
        }
        ArtistAPIClient.manager.getArtists(named: str,
                                           completionHandler: setArtists, errorHandler: printErrors)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.searchBar.delegate = self
    }
}

extension ArtistViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Artist cell", for: indexPath)
        let artist = artists[indexPath.row]
        cell.textLabel?.text = artist.trackName
        cell.detailTextLabel?.text = artist.artistName
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let lyricDVC = segue.destination as? LyricViewController {
            lyricDVC.artist = artists[tableView.indexPathForSelectedRow!.row]
        }
    }
}

extension ArtistViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = self.searchBar.text ?? ""
    }
}
