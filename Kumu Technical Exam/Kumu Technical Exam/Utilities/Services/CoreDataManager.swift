//
//  CoreDataService.swift
//  Kumu Technical Exam
//
//  Created by Erica Caber on 7/19/21.
//  Copyright © 2021 JM Sumague. All rights reserved.
//

import UIKit
import CoreData

final class CoreDataManager {
    static let sharedInstance = CoreDataManager()
    
    //to avoid accessing ManagedObjectContext from app delegate directly
    lazy var context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

}
