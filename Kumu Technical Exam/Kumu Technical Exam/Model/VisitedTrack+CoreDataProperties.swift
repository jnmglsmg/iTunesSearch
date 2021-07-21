//
//  VisitedTrack+CoreDataProperties.swift
//  Kumu Technical Exam
//
//  Created by Erica Caber on 7/20/21.
//  Copyright © 2021 JM Sumague. All rights reserved.
//
//

import Foundation
import CoreData


extension VisitedTrack {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VisitedTrack> {
        return NSFetchRequest<VisitedTrack>(entityName: "VisitedTrack")
    }

    @NSManaged public var lastVisit: Date?
    @NSManaged public var trackId: Int32

}
