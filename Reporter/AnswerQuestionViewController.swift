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

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // TODO
    // Save button
    
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderValue: UILabel!
    @IBOutlet weak var questionName: UILabel!
    
    
    var question: Question?
    var answers = [NSManagedObject]()
    
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        var currentValue = Int(sender.value)
        
        sliderValue.text = "\(currentValue)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionName.text = question?.text
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
