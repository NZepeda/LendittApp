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
    // This method sends out a post request to our authentication endpoint which returns a token
    // if token is successfully retrieved and stored into our keychain, we return true representing
    // a good response. Otherwise, we we return false.
    // *****************************************************************************************    
    static func register(_ data: [String: String], completionHandler: @escaping (Bool?, Error?) -> ()){
        print("In the authenticate method!");
        print("Data:  \(data)");
        
        Alamofire.request("https://lendittapi.herokuapp.com/api/v1/register", method: .post, parameters: data, encoding: URLEncoding.default).validate(statusCode: 200..<201).response { response in
            print("Response from server: \(response)");
            if(response.error == nil){
                let json = JSON(data: response.data!);
                
                if let token:String = json["token"].string {
                    print("Token \(token)");
                    let didInsertToKeychain = KeychainStore.insertTokenIntoKeychain(token: token);
                    
                    completionHandler(didInsertToKeychain, nil);
                }
                else{
                    print("Shit it failed");
                    let userInfo: [AnyHashable: Any] = [
                        NSLocalizedDescriptionKey : NSLocalizedString("TokenError", comment: "Failed to retrieve auth token"),
                        NSLocalizedFailureReasonErrorKey: NSLocalizedString("TokenError", comment: "Failed to retrieve auth token")
                    ]
                    let error = NSError(domain: "ApiCall", code: 500, userInfo: userInfo);
                    
                    completionHandler(false, error);
                }
            }
            else{
                print("Error: \(response.error)");
                completionHandler(false, response.error);
            }
        }
    }
}
