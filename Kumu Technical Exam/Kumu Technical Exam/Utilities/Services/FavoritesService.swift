//
//  FavoriteService.swift
//  Kumu Technical Exam
//
//  Created by Erica Caber on 7/20/21.
//  Copyright © 2021 JM Sumague. All rights reserved.
//

import Foundation
import CoreData

//Service for Favorite that relates to persistence
class FavoritesService {
    private let context = CoreDataManager.sharedInstance.context
    static let sharedInstance = FavoritesService()
    
    //MARK: Fetching
    
    //Get all favorites
    func fetchAllFavorite() -> [FavoriteTrack]? {
        do {
            //Build Request for fetching in Favorite Table
            let fetchRequest = NSFetchRequest<FavoriteTrack>(entityName: "FavoriteTrack")
            // Execute fetching
            let favorites = try context.fetch(fetchRequest)
            return favorites
        } catch {
            print(error)
            return nil
        }
    }
    
    //fetch filtered by id
    func fetchFavoriteWith(id: Int) -> FavoriteTrack? {
        let predicate = NSPredicate(format: "%K == %ld", "trackId", id)
        if let favorite = fetchFavoriteWith(predicate: predicate) {
            return favorite.first
        } else {
            return nil
        }
    }
    
    //fetch with custom predicate
    func fetchFavoriteWith(predicate: NSPredicate) -> [FavoriteTrack]? {
        do {
            //Request for fetching in Favorite Table
            let fetchRequest = NSFetchRequest<FavoriteTrack>(entityName: "FavoriteTrack")
            //Add predicate to fetch request to add specific queries
            fetchRequest.predicate = predicate
            // Execute fetching
            let favorites = try context.fetch(fetchRequest)
            return favorites
        } catch {
            print(error)
            return nil
        }
    }
    
    //MARK: Add Track to Favorites
    
    func setFavoriteTrack(track: Track) {
        //create Object
        let favorite = FavoriteTrack(context: context)
        //set value for properties
        favorite.setValue(track.trackId, forKey: "trackId")
        favorite.setValue(track.trackName, forKey: "trackName")
        do {
            //save context to apple changes / create new
            try context.save()
        } catch {
            print(error)
        }
    }
    
    //MARK: Delete Track from Favorites
    
    //In real cases this should be draft instead of hard delete
    func deleteFavorite(trackId: Int) {
        guard let favorite = fetchFavoriteWith(id: trackId) else {
            return
        }
        
        //delete object in Context
        context.delete(favorite)
        do {
            //save context to apple changes / create new
            try context.save()
        } catch {
            print(error)
        }
    }
}
