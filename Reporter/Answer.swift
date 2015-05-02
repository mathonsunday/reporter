//
//  Answer.swift
//  Reporter
//
//  Created by Veronica Ray on 3/9/15.
//  Copyright (c) 2015 Veronica Ray. All rights reserved.
//

import Foundation
import CoreData

public class Answer: NSManagedObject {

    @NSManaged var timestamp: NSDate
    @NSManaged var value: NSNumber
    @NSManaged var answerToQuestion: Question

}
