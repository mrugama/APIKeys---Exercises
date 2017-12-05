//
//  LyricViewController.swift
//  APIKeys - Exercises
//
//  Created by C4Q on 12/4/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class LyricViewController: UIViewController {
    
    @IBOutlet weak var lyricTextView: UITextView!
    
    var artist: Artist! {
        didSet {
            loadLyric()
        }
    }
    var lyric: Lyrics! {
        didSet {
            self.lyricTextView.text = lyric.lyricsBody
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func loadLyric() {
        let setLyric = {(onlineLyric: Lyrics) in
            self.lyric = onlineLyric
        }
        let printErrors = {(error: Error) in
            print(error)
        }
        LyricsAPIClient.manager.getLyrics(named: "\(artist.trackId)",
                                           completionHandler: setLyric, errorHandler: printErrors)
    }
    
}
