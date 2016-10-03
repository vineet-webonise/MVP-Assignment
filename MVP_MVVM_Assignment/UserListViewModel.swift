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
    func sendResponse(responseObject: AnyObject)
    func sendError(errorMessage:String)
}

class UserListViewModel: NSObject, NetworkConnectionHandlerDelegate {
    
    // MARK: Variable Declaration
    var userListModel :UserListModel!
    var arrayUsersListModel : NSMutableArray = []
    var arrayUsersListResponse : NSMutableArray = []
    var viewModelDelegate: MyViewModelDelegate?
    
    //This method will call API for getting User list
    func getUserList() {
        
        let networkDelegateHandler = NetworkConnectionHandler()
        networkDelegateHandler.networkDelegate = self
        networkDelegateHandler.getUserList(withTag: 0)
    }
    
    // MARK: Network Connection Methods
    func networkConnectionFinishedSuccessfully(responseObject: AnyObject, tag: NSInteger) {
        
        if tag == 0 {
            
            arrayUsersListModel = parseDataIntoModel(responseArray: responseObject) 
            viewModelDelegate?.sendResponse(responseObject: responseObject)
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
   
    // MARK: Parsing & Data handling methods
    func parseDataIntoModel(responseArray :AnyObject) -> NSMutableArray {
        let arrayUsers :NSMutableArray = []
        for index in 0 ..< responseArray.count {
            if let userDictionary = responseArray[index] as? [String:AnyObject]{
                userListModel = UserListModel()
                userListModel.mUserName  = userDictionary ["name"] as! String
                userListModel.mUserEmail = userDictionary["email"] as! String
                userListModel.mUserBody = userDictionary["body"] as! String
            }
            arrayUsers.add(userListModel)
        }
        
        return arrayUsers
    }
    
    func getUserObjectForIndex(index : Int) -> UserListModel {
        var userListModelObject = UserListModel()
        userListModelObject = arrayUsersListModel[index] as! UserListModel
        return userListModelObject
    }
    
    // Returning the Users count
    func getCountOfUsers() -> Int {
        return arrayUsersListModel.count
    }
}

