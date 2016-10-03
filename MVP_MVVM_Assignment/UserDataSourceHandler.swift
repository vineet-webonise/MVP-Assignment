//
//  UserDataSourceHandler.swift
//  MVP_MVVM_Assignment
//
//  Created by admin on 22/09/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import Swift

class UserDataSourceHandler: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Variable Declaration
    var userListViewModelObj :UserListViewModel!
    var userListModel :UserListModel!
    
    // MARK: TableView Delegate & Datasource Methods
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userListViewModelObj.getCountOfUsers()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UserListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "userCell") as! UserListTableViewCell!
        
        // populating the user data stored in objects of data model
        userListModel = userListViewModelObj.getUserObjectForIndex(index: indexPath.row)
        
        // Assigning the respective values to the labels of user data
        if((userListModel.mUserName != nil) && (userListModel.mUserEmail != nil) && (userListModel.mUserBody != nil)){
        cell.userName?.text = userListModel.mUserName.isRequiredNameCount(nameString: userListModel.mUserName ?? "")
        cell.userEmail?.text = userListModel.mUserEmail.isValidEmail(testEmailString:userListModel.mUserEmail ?? "")
        cell.userBody?.text = userListModel.mUserBody ?? ""
        }
        
        return cell
    }
    // Custom Cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
}
