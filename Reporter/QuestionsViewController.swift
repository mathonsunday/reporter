//
//  QuestionsViewController.swift
//  Reporter
//
//  Created by Veronica Ray on 2/20/15.
//  Copyright (c) 2015 Veronica Ray. All rights reserved.
//

import UIKit
import CoreData

class QuestionsViewController: UIViewController, UITableViewDataSource {
    
    // TODO
    // Swipe to delete questions
    // http://jamesonquave.com/blog/core-data-in-swift-tutorial-part-3/
    
    
    @IBOutlet weak var tableView: UITableView!
    var questions = [NSManagedObject]()
    let kCellIdentifier: String = "questionCell"
    
    @IBAction func addQuestion(sender: AnyObject) {
        var alert = UIAlertController(title: "New question",
            message: "Add a new question",
            preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save",
            style: .Default) { (action: UIAlertAction!) -> Void in
                
                let textField = alert.textFields![0] as UITextField
                self.saveText(textField.text)
                self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
            style: .Default) { (action: UIAlertAction!) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert,
            animated: true,
            completion: nil)
    }
    
    func saveText(text: String) {
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let entity =  NSEntityDescription.entityForName("Question",
            inManagedObjectContext:
            managedContext)
        
        let question = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext:managedContext)
        
        question.setValue(text, forKey: "text")
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        questions.append(question)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\"The Questions\""
        self.tableView.registerClass(UITableViewCell.self,
            forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"Question")
        
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            questions = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return questions.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as UITableViewCell
            
            let question = questions[indexPath.row]
            cell.textLabel!.text = question.valueForKey("text") as String?
            
            return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

