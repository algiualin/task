//
//  TaskDetailVC.swift
//  Task
//
//  Created by Pralea Danut on 26/04/16.
//  Copyright © 2016 Parhelion Software. All rights reserved.
//

import UIKit
import RMDateSelectionViewController


class TaskDetailVC: UIViewController {

    
   
    
    @IBOutlet weak var selectDateBtn: UIButton!
    
    @IBOutlet weak var taskDetailsTxtField: UITextField!
    
    var alertController: UIAlertController?
    
    var task: Task?
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureScreen()
       
        
    }

    func configureScreen() {
        if let task = task {
            self.title = "Edit Task"
           
            selectDateBtn.titleLabel!.text = task.date
            taskDetailsTxtField.text = task.taskDescription
            
        } else {
            self.title = "Add Task"
           
            selectDateBtn.titleLabel!.text = "Select Date"
            taskDetailsTxtField.text = ""
        }
    }
 
    
    
    @IBAction func selectDateTapped(sender: AnyObject) {
        
        let selectAction = RMAction(title: "Select", style: RMActionStyle.Done) { (controller) -> Void in
            
            if let pickerController = controller as? RMDateSelectionViewController {
                let dateFormatter = NSDateFormatter.init()
                dateFormatter.dateFormat = "MMM dd, yyyy"
                let dateString = dateFormatter.stringFromDate(pickerController.datePicker.date)
                self.selectDateBtn.setTitle(dateString, forState: .Normal)
            }
        }
        let cancelAction = RMAction(title: "Cancel", style: RMActionStyle.Cancel) { (controller) -> Void in
            self.selectDateBtn.setTitle("Select date", forState: .Normal)
        }
        
        let pickerController = RMDateSelectionViewController(style: .White, selectAction: selectAction, andCancelAction: cancelAction)
        self.presentViewController(pickerController!, animated: true) { () -> Void in
        }
    }
    
    @IBAction func cancelBtnPressed(sender: AnyObject) {
        
        navigationController?.popViewControllerAnimated(true)
      
        
    }
    
    
    @IBAction func saveBtnPressed(sender: AnyObject) {
        
        let task = Task(date: selectDateBtn.titleLabel!.text, taskDescription: taskDetailsTxtField.text, priority: "*************")
        tasks.append(task)
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    @IBAction func choosePriorityPressed(sender: AnyObject) {
        //********************************
       alertController = UIAlertController(title: "alert", message: "first alert", preferredStyle: Alert )
        presentViewController(alertController!, animated: true, completion: nil)
        
//        let oneAction = UIAlertAction(title: "One", style: .Default) { (_) in }
//        let twoAction = UIAlertAction(title: "Two", style: .Default) { (_) in }
//        let threeAction = UIAlertAction(title: "Three", style: .Default) { (_) in }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }
//        
//        alertController.addAction(oneAction)
//        alertController.addAction(twoAction)
//        alertController.addAction(threeAction)
//        alertController.addAction(cancelAction)
        
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
