//
//  VisitedTracksService.swift
//  Kumu Technical Exam
//
//  Created by Erica Caber on 7/20/21.
//  Copyright © 2021 JM Sumague. All rights reserved.
//

import Foundation
import CoreData

//Service saving Visited Track Ids
class VisitedTracksService {
    private let context = CoreDataManager.sharedInstance.context
    static let sharedInstance = VisitedTracksService()
    
    func fetchVisitedTrackWith(id: Int) -> VisitedTrack? {
        let predicate = NSPredicate(format: "%K == %ld", "trackId", id)
        if let visitedTrack = fetchVisitedTrackWith(predicate: predicate) {
            return visitedTrack
        } else {
            return nil
        }
    }
    
    //custom predicate fetching
    private func fetchVisitedTrackWith(predicate: NSPredicate) -> VisitedTrack? {
        do {
            //Request for fetching in VisitedTrack Table
            let fetchRequest = NSFetchRequest<VisitedTrack>(entityName: "VisitedTrack")
            //Add predicate to fetch request to add specific queries
            fetchRequest.predicate = predicate
            // Execute fetching
            let favorites = try context.fetch(fetchRequest)
            if favorites.count != 0 {
                return favorites.first
            } else {
                return nil
            }
        } catch {
            print(error)
            return nil
        }
    }
    
    func setVisitDate(trackId: Int, currentDate: Date) {
        //create Object
        let visited = fetchVisitedTrackWith(id: trackId) ?? VisitedTrack(context: context)
        
        //set value for properties
        visited.setValue(trackId, forKey: "trackId")
        visited.setValue(currentDate, forKey: "lastVisit")
        do {
            //save context to apple changes / create new
            try context.save()
        } catch {
            print(error)
        }
    }
}
