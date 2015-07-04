//
//  AnswersViewController.swift
//  Reporter
//
//  Created by Veronica Ray on 2/28/15.
//  Copyright (c) 2015 Veronica Ray. All rights reserved.
//

import UIKit
import CoreData
import Charts

class AnswersViewController: UIViewController, NSFetchedResultsControllerDelegate  {
    
    var question: Question?
    var answers = [Answer]()
    
var months: [String]!
    @IBOutlet weak var lineChartView: LineChartView!
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    
    func setChart() {
    
        lineChartView.noDataText = "You need to have at least one answer in order to see your data."
        var dataEntries: [ChartDataEntry] = []
        var dateTimes: [String] = []
           println("gets here")
        for i in 0..<answers.count {
            let answer = answers[i]
            let value  = answer.valueForKey("value") as! Double
            let dataEntry = ChartDataEntry(value: value, xIndex: i)
            dataEntries.append(dataEntry)
            
            let timestamp = answer.valueForKey("timestamp") as! NSDate?
            var formatter: NSDateFormatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.ShortStyle
            formatter.timeStyle = NSDateFormatterStyle.ShortStyle
            let dateTime = formatter.stringFromDate(timestamp!) as NSString
          dateTimes.append(dateTime as String)
}
        
        let chartDataSet = LineChartDataSet(yVals: dataEntries, label: "Units Sold")
        let chartData = LineChartData(xVals: dateTimes, dataSet: chartDataSet)
        lineChartView.data = chartData
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultController = getFetchedResultController()
        fetchedResultController.delegate = self
        fetchedResultController.performFetch(nil)
            initializeAnswers()
              setChart()
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
            self.answers.append(answer as! Answer)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
