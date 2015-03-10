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
    
    // TODO
    // Calender view with answers displayed for each day
    // https://github.com/devinross/tapkulibrary
    // Chart view
    //https://github.com/Jawbone/JBChartView
    //https://github.com/zemirco/swift-linechart
    
        var question: Question?
      var answers = [Answer]()
    
    @IBOutlet weak var tableView: UITableView!
     let kCellIdentifier: String = "answerCell"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self,
            forCellReuseIdentifier: "cell")
        fetchAnswers()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
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
    
    func fetchAnswers() {
        let fetchRequest = NSFetchRequest(entityName: "Answer")
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        let predicate = NSPredicate(format: "ANY answerToQuestion == %@", question!)
        fetchRequest.predicate = predicate
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        if let fetchResults = managedContext.executeFetchRequest(fetchRequest, error: nil) as? [Answer] {
            answers = fetchResults
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
