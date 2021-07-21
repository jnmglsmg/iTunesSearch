//
//  AudioListService.swift
//  Kumu Technical Exam
//
//  Created by Erica Caber on 7/17/21.
//  Copyright © 2021 JM Sumague. All rights reserved.
//

import UIKit
import CoreData


class MovieListService {
    
    //Base Track Fetching
    func fetchMovies(completion:@escaping (_ result: TrackResult?, _  error: Error?) -> Void) {
        let urlString = "https://itunes.apple.com/search?term=star&country=au&media=movie&limit=25"
        NetworkService.shared.loadData(with: urlString) { (result, error) in
            guard let result = result, error == nil else {
                return completion(nil, error)
            }
            
            do {
                let parsedResult = try JSONDecoder().decode(TrackResult.self, from: result)
                completion(parsedResult, nil)
            } catch let error {
                completion(nil, error)
            }
        }
    }
    
    //search method
    func fetchTrackWithPhrase(phrase: String, completion: @escaping (_ result: TrackResult?, _  error: Error?) -> Void) {
        let urlString = "https://itunes.apple.com/search?term=\(phrase)&country=au&media=movie&limit=5"
        NetworkService.shared
            .loadData(with: urlString) { (result, error) in
                guard let result = result, error == nil else {
                    return completion(nil, error)
                }
                
                //attempt to parse result into TrackResult
                do {
                    let parsedResult = try JSONDecoder().decode(TrackResult.self, from: result)
                    completion(parsedResult, nil)
                } catch let error {
                    completion(nil, error)
                }
        }
    }
}
