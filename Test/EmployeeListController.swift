//
//  EmployeeListController.swift
//  Test
//
//  Created by Tahia Ata on 11/3/16.
//  Copyright © 2016 Tahia Ata. All rights reserved.
//

import UIKit

class EmployeeListController: UITableViewController {

    let employeeListName = "employeeList.plist"
    var employeeDictionary : NSMutableDictionary!
    var employeeListArray = [Dictionary<String,String>]()
//    var searchEmployeeIndex: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.displaySearchResult(_:)), name: "DisplaySearchResult", object: nil)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }

//    deinit {
//        NSNotificationCenter.defaultCenter().removeObserver(self)
//    }

    func loadData() {
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let basePath = path.first
        let employeeListPath = basePath!.stringByAppendingPathComponent(employeeListName)
        if NSFileManager.defaultManager().fileExistsAtPath(employeeListPath){
            employeeDictionary = NSMutableDictionary(contentsOfFile: employeeListPath)
            employeeListArray = employeeDictionary["employee"] as! [Dictionary<String,String>]
            tableView.reloadData()
        }
    }

//    func displaySearchResult(notification: NSNotification) {
//        searchEmployeeIndex = Int((notification.object as! String))
//        self.performSegueWithIdentifier("show", sender: self)
//
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeListArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let employee = employeeListArray[indexPath.row]
        cell.textLabel?.text = employee["name"]
        cell.detailTextLabel?.text = employee["address"]
        return cell
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let employeeVC = segue.destinationViewController as! EmployeeCreateController

        if segue.identifier == "create" {
            if employeeDictionary != nil {
                employeeVC.employeeDictionary = employeeDictionary
            }

        } else if segue.identifier == "show" {
            employeeVC.employeeDictionary = employeeDictionary
            let indexPath = self.tableView.indexPathForSelectedRow
//            if searchEmployeeIndex != nil { // coming from spotlight
//                employeeVC.employeeIndex = searchEmployeeIndex
//                employeeVC.employeeToDisplay = employeeListArray[searchEmployeeIndex]
//            } else { // coming from tableview
                employeeVC.employeeToDisplay = employeeListArray[(indexPath?.row)!]
                employeeVC.employeeIndex = (indexPath?.row)!
 //           }

        }

    }

}
