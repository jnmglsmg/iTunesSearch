//
//  FavoriteTrackListService.swift
//  Kumu Technical Exam
//
//  Created by Erica Caber on 7/21/21.
//  Copyright © 2021 JM Sumague. All rights reserved.
//

import Foundation

//Service for Favorite that relates to persistence
class FavoriteListService {
    private let context = CoreDataManager.sharedInstance.context
    let favoritesService = FavoritesService()
    
    func fetchAllTrackList(completion:@escaping (_ result: TrackResult?, _  error: Error?) -> Void) {
        guard let favorites = favoritesService.fetchAllFavorite() else {
            completion(nil, nil)
            return
        }
        
        //Get Ids and convert to array as Strings
        var favoriteIds: [String] = []
        for favorite in favorites {
            favoriteIds.append(String(format: "%ld", favorite.trackId))
        }
        
        //append convertedIds for lookup
        let urlString = "https://itunes.apple.com/lookup?id=\(favoriteIds.joined(separator: ","))&country=au&limit=0"
        NetworkService.shared.loadData(with: urlString) { (result, error) in
            guard let result = result, error == nil else {
                return completion(nil, error)
            }
            
            //Parse into TrackResult Model
            do {
                let parsedResult = try JSONDecoder().decode(TrackResult.self, from: result)
                completion(parsedResult, nil)
            } catch let error {
                completion(nil, error)
            }
        }
    }
}
