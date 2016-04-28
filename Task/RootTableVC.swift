//
//  RootTableVC.swift
//  Task
//
//  Created by Pralea Danut on 26/04/16.
//  Copyright © 2016 Parhelion Software. All rights reserved.
//

import UIKit
import RMDateSelectionViewController

class RootTableVC: UITableViewController {

    var titleButton: UIButton = UIButton(type: .Custom)
    var task: Task!
    //var tasks = [Task]()
    var tasksWithDate = [Task]()
    var taskToSend: Task!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitleView()
        addTask()
        self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }

   
    func configureTitleView() {
        let titleButtonFrame = CGRectMake(0, 0, 120, 44)
        let titleButton = UIButton(frame: titleButtonFrame)
        titleButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        titleButton.setTitle("Select Date", forState: .Normal)
        self.titleButton = titleButton
        self.titleButton.addTarget(self, action: #selector(RootTableVC.onCalBtnTapped), forControlEvents: .TouchUpInside)
        self.navigationItem.titleView = self.titleButton
        
    }
    
    func onCalBtnTapped () {
        
        self.tasksWithDate.removeAll()

        let selectAction = RMAction(title: "Select", style: RMActionStyle.Done) { (controller) -> Void in
            
            if let pickerController = controller as? RMDateSelectionViewController {
                let dateFormatter = NSDateFormatter.init()
                dateFormatter.dateFormat = "MMM dd, yyyy"
                let dateString = dateFormatter.stringFromDate(pickerController.datePicker.date)
                self.titleButton.setTitle(dateString, forState: .Normal)
                self.selectTasksWithDate(dateString)
                self.tableView.reloadData()
             
            }
        }
        let cancelAction = RMAction(title: "Cancel", style: RMActionStyle.Cancel) { (controller) -> Void in
            self.titleButton.setTitle("Select date", forState: .Normal)
        }
        
        let pickerController = RMDateSelectionViewController(style: .White, selectAction: selectAction, andCancelAction: cancelAction)
        self.presentViewController(pickerController!, animated: true) { () -> Void in
        }
    }
    
    func addTask() {
        
        
        
        let task1 = Task(date: "May 01, 2016", taskDescription: "First task", priority: "red")
        tasks.append(task1)
        let task2 = Task(date: "May 02, 2016", taskDescription: "Second task", priority: "green")
        tasks.append(task2)
        let task3 = Task(date: "May 01, 2016", taskDescription: "Third task", priority: "blue")
        tasks.append(task3)
    }
    
    func selectTasksWithDate(dateString: String!){
        for task in tasks {
            if task.date == dateString{
                tasksWithDate.append(task)
            }
        }
        self.tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasksWithDate.count
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let taskToDelete = tasksWithDate[indexPath.row]
            for x in 0...tasks.count - 1 {
                if compareTasks(tasks[x], taskToDelete: taskToDelete) == true {
                    tasks.removeAtIndex(x)
                }
            }
            tasksWithDate.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        taskToSend = tasksWithDate[indexPath.row]
        performSegueWithIdentifier("AddTaskSegue", sender: tasksWithDate[indexPath.row])
        
    }
    
    
    func compareTasks(task: Task!, taskToDelete: Task!) -> Bool {
        
        if task.date == taskToDelete.date && task.taskPriority == taskToDelete.taskPriority && task.taskDescription == taskToDelete.taskDescription {
            return true
        }
        return false
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as? Cell
        cell?.taskDescription.text = tasksWithDate[indexPath.row].taskDescription
       // cell?.taskDate.text = tasksWithDate[indexPath.row].date
        switch tasksWithDate[indexPath.row].taskPriority {
        case "black":
            cell?.backgroundColor = UIColor.lightGrayColor()
        case "red":
            cell?.backgroundColor = UIColor.redColor()
        case "orange":
            cell?.backgroundColor = UIColor.orangeColor()
        case "green":
            cell?.backgroundColor = UIColor.greenColor()
        case "blue":
            cell?.backgroundColor = UIColor.blueColor()
        default:
            cell?.backgroundColor = UIColor.whiteColor()
        }

        return cell!
    }
 
   

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destinationVC = segue.destinationViewController as? TaskDetailVC
        destinationVC!.task = taskToSend
        
    }
 

}
