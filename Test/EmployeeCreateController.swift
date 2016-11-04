//
//  EmployeeCreateController.swift
//  Test
//
//  Created by Tahia Ata on 11/3/16.
//  Copyright © 2016 Tahia Ata. All rights reserved.
//

import UIKit
//import CoreSpotlight
//import MobileCoreServices

class EmployeeCreateController: UITableViewController {

    @IBOutlet weak var employeeNameField: UITextField!
    @IBOutlet weak var employeeAddressView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    let employeeListName = "employeeList.plist"
    var employeeDictionary : NSMutableDictionary!
    var employeeListArray = [Dictionary<String,String>]()

    var employeeToDisplay = Dictionary<String,String>()
    var employeeIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        if employeeDictionary != nil {
            employeeListArray = employeeDictionary["employee"] as! [Dictionary<String,String>]

            if employeeToDisplay["name"] != nil {
                  employeeNameField.text =  employeeToDisplay["name"]
                employeeAddressView.text = employeeToDisplay["address"]
            }
        }
        self.navigationItem.rightBarButtonItem = saveButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getEmployee() -> Dictionary<String,String> {
        var employee = [String:String]()

            employee = ["name":employeeNameField.text!, "address": employeeAddressView.text]

        return employee
    }

//    func addToSpotlight(employee: Dictionary<String,String>) {
//        let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
//        attributeSet.title = employee["name"]
//        attributeSet.contentDescription = employee["address"]
//
//        let searchItem = CSSearchableItem(uniqueIdentifier: "\(employeeIndex)", domainIdentifier: "xyz.Test", attributeSet: attributeSet)
//        CSSearchableIndex.defaultSearchableIndex().indexSearchableItems([searchItem]) {(error:NSError?) -> Void in
//            if error != nil {
//                print(error!.localizedDescription)
//            }
//        }
//        
//    }


    @IBAction func employeeSaveAction(sender: AnyObject) {
       if employeeNameField.text != "" && employeeAddressView.text != "" {
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let basePath = path.first
        let employeeListPath = basePath!.stringByAppendingPathComponent(employeeListName)

        if employeeToDisplay["name"] != nil {
                employeeListArray[employeeIndex] = getEmployee()
        } else {
            employeeListArray.append(getEmployee())
            employeeIndex = employeeListArray.count - 1
        }

      //  addToSpotlight(getEmployee())

        if employeeDictionary == nil {
                        employeeDictionary = NSMutableDictionary()
                     }

        employeeDictionary["employee"] = employeeListArray

        employeeDictionary.writeToFile(employeeListPath, atomically: true)
        self.navigationController?.popViewControllerAnimated(true)
        }
    }

}
