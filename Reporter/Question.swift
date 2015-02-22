//
//  Question.swift
//  Reporter
//
//  Created by Veronica Ray on 2/21/15.
//  Copyright (c) 2015 Veronica Ray. All rights reserved.
//

import Foundation
import CoreData

class Question: NSManagedObject {

    @NSManaged var text: String
    @NSManaged var answers: NSSet

}
