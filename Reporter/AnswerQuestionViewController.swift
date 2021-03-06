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
        let entityDescripition = NSEntityDescription.entityForName("Answer", inManagedObjectContext: managedObjectContext!)
        let answer = Answer(entity: entityDescripition!, insertIntoManagedObjectContext: managedObjectContext)
        answer.setValue(currentValue, forKey: "value")
        answer.setValue(self.question, forKey: "answerToQuestion")
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
        let hour = components.hour
        let minutes = components.minute
        answer.setValue(date, forKey: "timestamp")
        var error: NSError?
        if !managedObjectContext!.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        saveButton.enabled = false
        slider.enabled = false
    }
    var question: Question?
    var answers = [NSManagedObject]()
    var currentValue: Int = 0
    @IBAction func sliderValueChanged(sender: UISlider) {
        currentValue = Int(sender.value)
        sliderValue.text = "\(currentValue)"
    }
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    func saveValue(value: NSNumber) {
        

    }
    
    func saveTimestamp(timestamp: NSDateComponents) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if question != nil {
            questionName.text = question?.text
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
