//
//  AnswerQuestionViewController.swift
//  Reporter
//
//  Created by Veronica Ray on 2/28/15.
//  Copyright (c) 2015 Veronica Ray. All rights reserved.
//

import UIKit
import CoreData

class AnswerQuestionViewController: UIViewController {
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderValue: UILabel!
    @IBOutlet weak var questionName: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    @IBAction func addAnswer(sender: AnyObject) {
                self.saveValue(currentValue)
    }
    
    var question: Question?
    var answers = [NSManagedObject]()
    var currentValue: Int
 = 0
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        currentValue = Int(sender.value)
        
        sliderValue.text = "\(currentValue)"
    }
    
    func saveValue(value: NSNumber) {
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let entity =  NSEntityDescription.entityForName("Answer",
            inManagedObjectContext:
            managedContext)
        
        let answer = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext:managedContext)
        
        answer.setValue(value, forKey: "value")
        answer.setValue(self.question, forKey: "answerToQuestion")
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        saveButton.enabled = false
        slider.enabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionName.text = question?.text
        println(question?.text)
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
