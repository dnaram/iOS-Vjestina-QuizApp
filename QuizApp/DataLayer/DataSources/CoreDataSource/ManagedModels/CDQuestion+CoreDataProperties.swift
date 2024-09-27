//
//  CDQuestion+CoreDataProperties.swift
//  
//
//  Created by Andrea Stanic on 06.06.2021..
//
//

import Foundation
import CoreData


extension CDQuestion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDQuestion> {
        return NSFetchRequest<CDQuestion>(entityName: "CDQuestion")
    }

    @NSManaged public var correctAnswer: Int16
    @NSManaged public var answers: [String]?
    @NSManaged public var uid: Int16
    @NSManaged public var question: String?

}
