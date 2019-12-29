//
//  Login.swift
//  Prueba_iOS
//
//  Created by Daniel Pérez Parreño on 27/12/2019.
//  Copyright © 2019 Daniel Pérez Parreño. All rights reserved.
//

import Foundation

class LoginConfigurator {
    
    var websocketApiService : WebsocketApiService
    
    init(websocketApiService: WebsocketApiService) {
        self.websocketApiService = websocketApiService
    }
    
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    
    func sendAutenticate(email: String, password: String, completionHandler: @escaping (Bool) -> Void){
        var isAutenticate = false
        let parameters: [String: Any] = [
            "cmd": "LOGIN" as Any,
            "email" : email as Any,
            "password" : password as Any
        ]
        
        websocketApiService.sendMessageToWebsocket(parameters: parameters, completionHandler: {result in
            if let jsonResult = result["successful"] {
                if jsonResult["content"]["status"] == "logged" {
                    //--- Saved TOKEN if is necessary ---//
                    _ = jsonResult["content"]["token"].stringValue
                    //---------------------------------//
                    isAutenticate = true
                }
            }
            completionHandler(isAutenticate)
        })
    }
    
}
