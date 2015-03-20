//
//  AnswersViewController.swift
//  Reporter
//
//  Created by Veronica Ray on 2/28/15.
//  Copyright (c) 2015 Veronica Ray. All rights reserved.
//

import UIKit
import CoreData

class AnswersViewController: UIViewController, UITableViewDataSource {
    
    var question: Question?
    var answers = [NSManagedObject]()
    @IBOutlet weak var tableView: UITableView!
    let kCellIdentifier: String = "answerCell"
    var managedObjectContext : NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self,
            forCellReuseIdentifier: "cell")
        fetchAnswers()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    
    func fetchAnswers() {
        let fetchRequest = NSFetchRequest(entityName: "Answer")
        let predicate = NSPredicate(format: "ANY answerToQuestion == %@", question!)
        fetchRequest.predicate = predicate
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Answer] {
            answers = fetchResults
        }
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return answers.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as UITableViewCell
            let answer = answers[indexPath.row]
            let value  = answer.valueForKey("value") as NSNumber?
            cell.textLabel!.text = value?.stringValue
            return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
