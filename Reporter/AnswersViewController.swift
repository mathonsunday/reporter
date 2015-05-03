//
//  AnswersViewController.swift
//  Reporter
//
//  Created by Veronica Ray on 2/28/15.
//  Copyright (c) 2015 Veronica Ray. All rights reserved.
//

import UIKit
import CoreData

class AnswersViewController: UIViewController, UITableViewDataSource,  NSFetchedResultsControllerDelegate  {
    
    var question: Question?
    var answers = [Answer]?()
    @IBOutlet weak var tableView: UITableView!
    let kCellIdentifier: String = "answerCell"
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self,
            forCellReuseIdentifier: "cell")
        fetchedResultController = getFetchedResultController()
        fetchedResultController.delegate = self
        fetchedResultController.performFetch(nil)
            initializeAnswers()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    // MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let numberOfSections = fetchedResultController.sections?.count
        return numberOfSections!
    }
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            let numberOfRowsInSection = fetchedResultController.sections?[section].numberOfObjects
            return numberOfRowsInSection!
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as UITableViewCell
            let answer = fetchedResultController.objectAtIndexPath(indexPath) as Answer
            let value  = answer.valueForKey("value") as NSNumber?
            let timestamp = answer.valueForKey("timestamp") as NSDate?
            var formatter: NSDateFormatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.ShortStyle
            formatter.timeStyle = NSDateFormatterStyle.ShortStyle
            let dateTime = formatter.stringFromDate(timestamp!) as NSString
             cell.textLabel!.text = "Value " + value!.stringValue + " Time " + dateTime
            return cell
    }
    
    // MARK: NSFetchedResultsControllerDelegate
    func getFetchedResultController() -> NSFetchedResultsController {
        fetchedResultController = NSFetchedResultsController(fetchRequest: answerFetchRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }
    
    func answerFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Answer")
        let predicate = NSPredicate(format: "ANY answerToQuestion == %@", question!)
        fetchRequest.predicate = predicate
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    func initializeAnswers() {
        for answer in self.fetchedResultController.fetchedObjects! {
            self.answers?.append(answer as Answer)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
