//
//  NSString+Validations.swift
//  MVP_MVVM_Assignment
//
//  Created by admin on 28/09/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

extension String {
    
        // MARK: User Email Validation Method
    
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
    
    // MARK: User Name Validation Method
        func isRequiredNameCount(nameString:String) -> String {
            
            let nameWordsArray = nameString.characters.split{$0 == " "}.map(String.init)
            
            if(nameWordsArray.count == 3){
                let resultantNameString = nameWordsArray[0] + " " + nameWordsArray[1] + " " + nameWordsArray[2]
                return resultantNameString
            }else{
                let resultantNameString = nameWordsArray[0] +  " " + nameWordsArray[1] + " " + nameWordsArray[2] + ".."
                return resultantNameString
            }
            
        }
}
