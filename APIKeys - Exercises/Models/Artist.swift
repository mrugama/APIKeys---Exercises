//
//  Artist.swift
//  APIKeys - Exercises
//
//  Created by C4Q on 12/4/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

struct AllInfo: Codable {
    let message: Message
}

struct Message: Codable {
    let body: Body
}

struct Body: Codable {
    let trackList: [TrackList]?
    let lyrics: Lyrics?
    enum CodingKeys: String, CodingKey {
        case trackList = "track_list"
        case lyrics
    }
}

struct Lyrics: Codable {
    let lyricsId: Int
    let lyricsBody: String
    enum CodingKeys: String, CodingKey {
        case lyricsId = "lyrics_id"
        case lyricsBody = "lyrics_body"
    }
}

struct TrackList: Codable {
    let track: Artist
}

struct Artist: Codable {
    let trackId: Int
    let trackName: String
    let albumName: String
    let artistId: Int
    let artistName: String
    enum CodingKeys: String, CodingKey {
        case trackId = "track_id"
        case trackName = "track_name"
        case albumName = "album_name"
        case artistId = "artist_id"
        case artistName = "artist_name"
    }
}
