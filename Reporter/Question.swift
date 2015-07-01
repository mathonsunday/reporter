//
//  Question.swift
//  Reporter
//
//  Created by Veronica Ray on 3/9/15.
//  Copyright (c) 2015 Veronica Ray. All rights reserved.
//

import Foundation
import CoreData

class Question: NSManagedObject {

    @NSManaged var text: String
    @NSManaged var questionToAnswers: NSSet
    
    class func createInManagedObjectContext(moc: NSManagedObjectContext, text: String) -> Question {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Question", inManagedObjectContext: moc) as! Question
        newItem.text = text
        return newItem
    }

}
