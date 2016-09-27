//
//  ViewController.swift
//  MVP_MVVM_Assignment
//
//  Created by admin on 22/09/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MyViewModelDelegate {
    
    private let userDataSource = UserDataSourceHandler()
    var userListViewModel :UserListViewModel!
    
    var arrayInvoicesModel :NSMutableArray = []
    @IBOutlet weak var tableViewUserList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        userListViewModel = UserListViewModel()
        userListViewModel.viewModelDelegate = self
        userListViewModel.getUserList()
    }
    
    func sendResponse(responseObject: NSDictionary) {
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
            showAlertViewWithMessage(message: "No records found")
        }
    }
    
    func sendError(errorMessage: String) {
        showAlertViewWithMessage(message: errorMessage)
    }
    
    func showAlertViewWithMessage(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

