//
//  UserDataSourceHandler.swift
//  MVP_MVVM_Assignment
//
//  Created by admin on 22/09/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import Swift

extension String {
    
    func isValidEmail(testEmailString:String) -> String {
        
        let emailStringContents = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTestString = NSPredicate(format:"SELF MATCHES %@", emailStringContents)
        
        let emailValidBool = emailTestString.evaluate(with: testEmailString)
        if(emailValidBool == true){
            return (testEmailString as NSString).lowercased
        }else{
            
            return "-"
        }
        
        
    }
    
    func isRequiredNameCount(nameString:String) -> String {
        
        let nameWordsArray = nameString.characters.split{$0 == " "}.map(String.init)
        
        if(nameWordsArray.count == 3){
            let resultantNameString = nameWordsArray[0] + nameWordsArray[1] + nameWordsArray[2]
            return resultantNameString
        }else{
            let resultantNameString = nameWordsArray[0] + nameWordsArray[1] + nameWordsArray[2] + ".."
            return resultantNameString
        }
        
    }
    
}

class UserDataSourceHandler: NSObject, UITableViewDelegate, UITableViewDataSource {
    var userListViewModelObj :UserListViewModel!
    var userListModel :UserListModel!
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userListViewModelObj.getCountOfUsers()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UserListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "userCell") as! UserListTableViewCell!
        userListModel = userListViewModelObj.getUserObjectForIndex(index: indexPath.row)
        cell.userName?.text = userListModel.userName.isRequiredNameCount(nameString: userListModel.userName)
        cell.userEmail?.text = userListModel.userEmail.isValidEmail(testEmailString:userListModel.userEmail)
        cell.userBody?.text = userListModel.userBody
        
        return cell
    }
}
