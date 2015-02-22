//
//  Answer.swift
//  Reporter
//
//  Created by Veronica Ray on 2/21/15.
//  Copyright (c) 2015 Veronica Ray. All rights reserved.
//

import Foundation
import CoreData

class Answer: NSManagedObject {

    @NSManaged var value: NSNumber
    @NSManaged var timestamp: NSDate
    @NSManaged var question: NSManagedObject

}
