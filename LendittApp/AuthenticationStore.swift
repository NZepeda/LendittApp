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

class AuthenticationStore {
    
    // Test protected endpoint
    static func authenticate(data: [String: String]) -> Bool {
        
        var didAuthenticate = false;
        
        Alamofire.request("https://lendittapi.herokuapp.com/api/v1/authenticate", method: .post, parameters: data, encoding: URLEncoding.default).validate(statusCode: 200..<201).response { response in
            
            let json = JSON(data: response.data!)
            
            if let token : String = json["token"].string {
                didAuthenticate =  KeychainStore.insertTokenIntoKeychain(token: token);
            }
            
        }
        
        return didAuthenticate;
    }
}
