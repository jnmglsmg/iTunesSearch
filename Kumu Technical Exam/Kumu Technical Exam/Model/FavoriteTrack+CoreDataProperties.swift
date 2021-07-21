//
//  FavoriteTrack+CoreDataProperties.swift
//  Kumu Technical Exam
//
//  Created by Erica Caber on 7/20/21.
//  Copyright © 2021 JM Sumague. All rights reserved.
//
//

import Foundation
import CoreData


extension FavoriteTrack {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteTrack> {
        return NSFetchRequest<FavoriteTrack>(entityName: "FavoriteTrack")
    }

    @NSManaged public var trackId: Int32
    @NSManaged public var trackName: String?

}
