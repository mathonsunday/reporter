//
//  QuestionsViewController.swift
//  Reporter
//
//  Created by Veronica Ray on 2/20/15.
//  Copyright (c) 2015 Veronica Ray. All rights reserved.
//

import UIKit
import CoreData

class AddQuestionViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var questions = [Question]()
    let kCellIdentifier: String = "questionCell"
     let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    @IBAction func addQuestion(sender: AnyObject) {
        var alert = UIAlertController(title: "Add A New Question",
            message: nil,
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
            textField.placeholder = "How much pain is in your left wrist?"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert,
            animated: true,
            completion: nil)
    }
    
    func saveText(text: String) {
        var newQuestion = Question.createInManagedObjectContext(self.managedObjectContext!, text: text)
        self.fetchQuestions()
        if let newItemIndex = find(questions, newQuestion) {
            let newQuestionIndexPath = NSIndexPath(forRow: newItemIndex, inSection: 0)
            tableView.insertRowsAtIndexPaths([ newQuestionIndexPath ], withRowAnimation: .Automatic)
            save()
        }
    }
    
    func save() {
        var error : NSError?
        if(managedObjectContext!.save(&error) ) {
            println(error?.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self,
            forCellReuseIdentifier: "cell")
        fetchQuestions()
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var detailsViewController: AnswerQuestionViewController = segue.destinationViewController as AnswerQuestionViewController
        var questionIndex = tableView!.indexPathForSelectedRow()!.row
        var selectedQuestion = self.questions[questionIndex]
        detailsViewController.question = selectedQuestion
        detailsViewController.managedObjectContext = managedObjectContext
    }
    
     // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == .Delete ) {
            let questionToDelete = questions[indexPath.row]
            managedObjectContext?.deleteObject(questionToDelete)
            self.fetchQuestions()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            save()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

