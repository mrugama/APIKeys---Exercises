//
//  ArtistAPIClient.swift
//  APIKeys - Exercises
//
//  Created by C4Q on 12/4/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation
class ArtistAPIClient {
    private init(){}
    static let manager = ArtistAPIClient()
    func getArtists(named str: String,
                    completionHandler: @escaping ([Artist]) -> Void,
                    errorHandler: @escaping (Error) -> Void) {
//        let appId = "2a8e7cb2"
        let appKey = "755bf544d61c79ccfa62ed90bb5e3984"
        let urlStr = "http://api.musixmatch.com/ws/1.1/track.search?q_artist=\(str)&apikey=\(appKey)"
        guard let url = URL(string: urlStr) else {errorHandler(AppError.badURL); return}
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let AllArtistInfo = try JSONDecoder().decode(AllInfo.self, from: data)
                let message = AllArtistInfo.message
                let body = message.body
                let trackList = body.trackList
                if let track = trackList {
                    completionHandler(track.map({$0.track}))
                }
            } catch {
                errorHandler(AppError.couldNotParseJSON(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
    }
}
