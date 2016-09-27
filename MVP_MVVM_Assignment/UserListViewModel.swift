//
//  UserListViewModel.swift
//  MVP_MVVM_Assignment
//
//  Created by admin on 22/09/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit
import Swift

@objc protocol MyViewModelDelegate{
    func sendResponse(responseObject: NSDictionary)
    func sendError(errorMessage:String)
}

class UserListViewModel: NSObject, NetworkConnectionHandlerDelegate {
    var userListModel :UserListModel!
    var arrayUsersListModel :NSMutableArray = []
    var viewModelDelegate: MyViewModelDelegate?
    
    /**
     This method will call API for getting invoice list
     */
    func getUserList() {
        
        let networkDelegateHandler = NetworkConnectionHandler()
        networkDelegateHandler.networkDelegate = self
        networkDelegateHandler.getUserList(withTag: 0)
        
    }
    
    func networkConnectionFinishedSuccessfully(responseObject: AnyObject, tag: NSInteger) {
        
        if tag == 0 {
            
            arrayUsersListModel = parseDataIntoModel(responseArray: responseObject as! NSArray)
            viewModelDelegate?.sendResponse(responseObject: responseObject as! NSDictionary)
        }
        else {
            print(responseObject)
        }
    }
    
    func networkConnectionDidFailWithError(errorMessage:String, tag: NSInteger) {
        viewModelDelegate?.sendError(errorMessage: errorMessage)
    }
    
    func networkRequestRejected(errorMessage:String, tag: NSInteger) {
        viewModelDelegate?.sendError(errorMessage: errorMessage)
    }
    
    func networkStatusInactive() {
        print("No internet connection")
    }
    
    func parseDataIntoModel(responseArray :NSArray) -> NSMutableArray {
        let arrayUsers :NSMutableArray = []
        
        for index in 0 ..< responseArray.count {
            //userListModel = UserListModel()
             // userListModel.userName = responseArray[index]["name"] as? String
            //userListModel.userName = responseArray.index(of: index)["name"] as! String
//            userListModel.userName = responseArray[index]["email"] as! String
//            userListModel.userName = responseArray[index]["body"] as! String
            arrayUsers.add(userListModel)
        }
        
        return arrayUsers
    }
    
    func getUserObjectForIndex(index : Int) -> UserListModel {
        var userListModelObject = UserListModel()
        userListModelObject = arrayUsersListModel[index] as! UserListModel
        return userListModelObject
    }
    
    func getCountOfUsers() -> Int {
        return arrayUsersListModel.count
    }
}

