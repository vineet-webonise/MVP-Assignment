//
//  ViewController.swift
//  MVP_MVVM_Assignment
//
//  Created by admin on 22/09/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MyViewModelDelegate {
    // MARK: IBOutlets
    @IBOutlet weak var tableViewUserList: UITableView!
    
    // MARK: Variable Declaration
    var userListViewModel :UserListViewModel!
    var arrayInvoicesModel :NSMutableArray = []
    private let userDataSource = UserDataSourceHandler()
    
    // MARK: View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        userListViewModel = UserListViewModel()
        userListViewModel.viewModelDelegate = self
        
        // API call for getting User Data
        userListViewModel.getUserList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Data Handling Methods
    func sendResponse(responseObject: AnyObject) {
        // Logic to populate the response data
        if userListViewModel.getCountOfUsers() > 0 {
            tableViewUserList.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            userDataSource.userListViewModelObj = userListViewModel
            tableViewUserList.delegate = userDataSource
            tableViewUserList.dataSource = userDataSource
            DispatchQueue.main.async {
                self.tableViewUserList.reloadData()
            }
        }
        else {
            showAlertViewWithMessage(message: CommonConstants.Constants.NoRecordsFound)
        }
    }
    // Method to handling response fail error
    func sendError(errorMessage: String) {
        showAlertViewWithMessage(message: errorMessage)
    }
    
    // Method to showing error messageof faliure
    func showAlertViewWithMessage(message: String) {
        let alert = UIAlertController(title: CommonConstants.Constants.ERROR, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: CommonConstants.Constants.OK, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

