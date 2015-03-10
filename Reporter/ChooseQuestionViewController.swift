//
//  ChooseQuestionViewController.swift
//  
//
//  Created by Veronica Ray on 3/8/15.
//
//

import UIKit
import CoreData

class ChooseQuestionViewController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    var questions = [NSManagedObject]()
    let kCellIdentifier: String = "questionCell"
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self,
            forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        
        let fetchRequest = NSFetchRequest(entityName:"Question")
        
        var error: NSError?
        
        let fetchedResults =
        managedObjectContext!.executeFetchRequest(fetchRequest,
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
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == .Delete ) {
            let questionToDelete = questions[indexPath.row]
            managedObjectContext?.deleteObject(questionToDelete)
            self.fetchQuestions()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    func fetchQuestions() {
        let fetchRequest = NSFetchRequest(entityName: "Question")
        let sortDescriptor = NSSortDescriptor(key: "text", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Question] {
            questions = fetchResults
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var detailsViewController: AnswersViewController = segue.destinationViewController as AnswersViewController
        var questionIndex = tableView!.indexPathForSelectedRow()!.row
        var selectedQuestion = self.questions[questionIndex]
        detailsViewController.question = selectedQuestion as? Question
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
