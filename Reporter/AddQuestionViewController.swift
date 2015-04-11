//
//  QuestionsViewController.swift
//  Reporter
//
//  Created by Veronica Ray on 2/20/15.
//  Copyright (c) 2015 Veronica Ray. All rights reserved.
//

import UIKit
import CoreData

class AddQuestionViewController: UIViewController, UITableViewDataSource,  NSFetchedResultsControllerDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    var questions = [Question]()
    let kCellIdentifier: String = "questionCell"
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    
    @IBAction func addQuestion(sender: AnyObject) {
        var alert = UIAlertController(title: "Add A New Question",
            message: nil,
            preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel",
            style: .Default) { (action: UIAlertAction!) -> Void in
        }
        
        
       let saveAction = UIAlertAction(title: "Save",
            style: .Default) { (action: UIAlertAction!) -> Void in
                let textField = alert.textFields![0] as UITextField
                if (!self.questions.filter { (question) in question.text == textField.text}.isEmpty) {
                self.saveText(textField.text)
                self.tableView.reloadData()
                } else {
                    var alertOnError = UIAlertController(title: "Question Already Exists",
                        message: nil,
                        preferredStyle: .Alert)
                    let okAction = UIAlertAction(title: "OK",
                        style: .Default) { (action: UIAlertAction!) -> Void in
                    }
                    alertOnError.addAction(okAction)
                    self.presentViewController(alertOnError,
                        animated: true,
                        completion: nil)
                }
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
            textField.placeholder = "How much pain is in your left wrist?"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert,
            animated: true,
            completion: nil)
    }
    
    func createRetryModal() {
        
    }
    
    func saveText(text: String) {
        let entityDescripition = NSEntityDescription.entityForName("Question", inManagedObjectContext: managedObjectContext!)
        let question = Question(entity: entityDescripition!, insertIntoManagedObjectContext: managedObjectContext)
        question.text = text
        managedObjectContext?.save(nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self,
            forCellReuseIdentifier: "cell")
        fetchedResultController = getFetchedResultController()
        fetchedResultController.delegate = self
        fetchedResultController.performFetch(nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func fetchQuestions() {
        let fetchRequest = NSFetchRequest(entityName: "Question")
        let sortDescriptor = NSSortDescriptor(key: "text", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Question] {
            questions = fetchResults
        }
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
            let question = fetchedResultController.objectAtIndexPath(indexPath) as Question
            cell.textLabel!.text = question.valueForKey("text") as String?
            
            return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let answerQuestionController:AnswerQuestionViewController = segue.destinationViewController as AnswerQuestionViewController
        let question:Question = fetchedResultController.objectAtIndexPath(indexPath!) as Question
        answerQuestionController.question = question
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let managedObject:NSManagedObject = fetchedResultController.objectAtIndexPath(indexPath) as NSManagedObject
        managedObjectContext?.deleteObject(managedObject)
        managedObjectContext?.save(nil)
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController!) {
        tableView.reloadData()
    }
    
    // MARK: NSFetchedResultsControllerDelegate
    func getFetchedResultController() -> NSFetchedResultsController {
        fetchedResultController = NSFetchedResultsController(fetchRequest: questionFetchRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }
    
    func questionFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Question")
        let sortDescriptor = NSSortDescriptor(key: "text", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

