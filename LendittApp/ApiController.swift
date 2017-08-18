//
//  AuthenticationStore.swift
//  LendittApp
//
//  Created by Nestor Zepeda on 7/20/17.
//  Copyright © 2017 Lenditt Co. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiController {
    
    // *****************************************************************************************
    // This method sends out a post request to our regiter endpoint. The response should look like
    // JSON : {
    //     "message" : "Successfully created the user",
    //     "sucess"  : true
    //  }
    // *****************************************************************************************    
    static func register(_ data: [String: String], completionHandler: @escaping (Bool?, Error?) -> ()){
        Alamofire.request("https://lendittapi.herokuapp.com/api/v1/register", method: .post, parameters: data, encoding: URLEncoding.default).validate(statusCode: 200..<201).response { response in
            if(response.error == nil){
                let json = JSON(data: response.data!);
                
                if let success = json["success"].bool {
                    if (success){
                        completionHandler(true, nil);
                    }
                }
                else{
                    completionHandler(false, createError(errorKey: "RegisterFailed", message: "There was an error creating the user"));
                }
            }
            else{
                completionHandler(false, response.error);
            }
        }
    }
    
    static func authenticate(_ data: [String: String], completionHandler: @escaping (Bool?, Error?) -> ()){
        
        let authData : [String: String] = [
            "email" : data["email"]!,
            "password" : data["password"]!
        ];
        
        Alamofire.request("https://lendittapi.herokuapp.com/api/v1/authenticate", method: .post, parameters: authData, encoding: URLEncoding.default).validate(statusCode: 200..<201).response { response in
            
            if(response.error == nil){
                let json = JSON(data: response.data!);
                
                if let token:String = json["token"].string {
                    
                    print("Token \(token)");
                    
                    let didInsertToKeychain = KeychainStore.insertTokenIntoKeychain(token: token);
                    
                    completionHandler(didInsertToKeychain, nil);
                }
                else{
                    print("Token was not present");
                    completionHandler(false, createError(errorKey: "TokenError", message: "Failed to retrieve auth toke"));
                }
            }
            else{
                print("Error: \(response.error)");
                completionHandler(false, response.error);
            }
        }

    }
    
    static func createError(errorKey: String, message: String) -> Error {
        
        let userInfo: [AnyHashable: Any] = [
            NSLocalizedDescriptionKey : NSLocalizedString(errorKey, comment: message),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString(errorKey, comment: message)
        ]
        
        return NSError(domain: "APICall", code: 500, userInfo: userInfo);
        
    }
}


