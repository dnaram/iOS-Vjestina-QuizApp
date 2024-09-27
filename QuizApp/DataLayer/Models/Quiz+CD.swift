//
//  Quiz+CD.swift
//  QuizApp
//
//  Created by Andrea Stanic on 06.06.2021..
//

import CoreData
import UIKit

extension Quiz {
    
    init(with entity: CDQuiz) {
        category = QuizCategory(rawValue: entity.category!)!
        description = entity.desc!
        id = Int(entity.uid)
        imageUrl = entity.imageUrl!
        level = Int(entity.level)
        title = entity.title!
        questions = entity.questions?.allObjects as! [Question]
    }
    
    func populate(_ entity: CDQuiz, in context: NSManagedObjectContext) {
        entity.category = category.rawValue
        entity.desc = description
        entity.uid = Int16(id)
        entity.imageUrl = imageUrl
        entity.level = Int16(level)
        entity.title = title
    }
}
